import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/constants/Constant.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/data/preferences/shared_preferences.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../data/network/apiservices/meridukaan_api_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/meridukaan/userdashboard/Equiry.dart';
import '../../notifire/cart_notifire.dart';
import '../../ui/module/home/home.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';
import 'package:crypto/crypto.dart';

class TotalVisitorController extends BaseController {
  final apiServices = Get.put(MeriDukaanApiServices());
  final cartApiServices = Get.put(CartApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final cartController = Get.find<CartController>();
  RxList<Equiry> get equiryList => cartController.cartList;
  final isLoader = false.obs;
  get totalPrice => cartController.totalValue;
  var result="";
  String transaction="transaction_${1000 + Random().nextInt(9000)}";

  void callUserDashboardCardCall(String dataType) async {
     isLoader.value = true;
     final response = await apiServices.totalVisitor(
         userId: appPreferences.userId, dataType: dataType);
     isLoader.value = false;
     if (response == null) Common.showToast("Server Error!");
     if (response != null && response.status == 200) {
       // equiryList = response.equiryList;
       totalPrice.value = 0;
       totalPrice.value = response.totalPrice;
     }
  }

  Future<void> createOrderId(amount, List<Map<String, dynamic>> items) async {
    showLoader();
    final response = await cartApiServices.createOrderApi();
    hideLoader();
    if (response == null) return;
    if (response.orders.isNotEmpty) {
      buyNow(response.phonepeResponse?.orderId??"", amount * 100,response.orders[0].merchantOrderId,response.phonepeResponse?.token??"");
    } else {
      Common.showToast("Something went wrong!");
    }
  }

  Future<void> createOrderIdForBook(amount) async {
    showLoader();
    final response = await cartApiServices.createOrderApi();
    hideLoader();
    if (response == null) return;
    if (response.orders.isNotEmpty) {
      debugPrint("sonu${response.orders} ::${amount * 100}");
      buyNow(response.phonepeResponse?.orderId??"", amount * 100,response.orders[0].merchantOrderId,response.phonepeResponse?.token??"");
    } else {
      Common.showToast("Something went wrong!");
    }
  }
  String getSalt(String orderId,int amount,String transaction) {

    String apiEndPoint = "/pg/v1/pay";
    var salt = "6ecedc1a-eed9-454b-9a07-5fd33d49dc5d";
    var index = 1;
    return "${sha256
        .convert(utf8.encode(getBody("335",amount,transaction) + apiEndPoint + salt))}###$index";
  }

  String getBody(String orderId,int amount,String transaction) {

    var body = {
      "merchantId": "M220EMX87XH1T",
      "merchantTransactionId": transaction,
      "merchantUserId": appPreferences.userId,
      "amount": 1000,
      "mobileNumber": appPreferences.mobile,
      "callbackUrl": "https://webhook.site/fb8f7b18-790f-4106-80cc-7ea57961dc86",
      "paymentInstrument": {"type": "PHONEPE"}
    }; // Encode the request body to JSON
    String jsonBody = jsonEncode(body);
    String base64EncodedBody = base64Encode(utf8.encode(jsonBody));
    return base64EncodedBody;
  }
  void navigate(String result,String orderId,int amount,String merchantTransectionId){
    if(result.contains("SUCCESS")){
      ShipRocketTransaction(merchantTransectionId,orderId,amount);
     /* saveTransaction(0, 0, "", "", orderId ?? "", totalPrice.value,
          "","", false);*/
    }else{
      Common.showToast("Payment Failed!");
    }
    //Home.start(0);
  }
  void buyNow(String orderId, int amount,String merchantId,String token)  {
     //String value=getSalt("335",amount,merchantId);
   /* bool isInstalled =  PhonePePaymentSdk.isPhonePeInstalled();

    if (!isInstalled) {
      handleError("PhonePe app is not installed");
      showAlertDialog(Get.context!, "PhonePe app is not installed","Please installed Phone pay app");

      return; // ❌ stop here
    }*/
     Map<String,dynamic> payload = {
       "orderId": merchantId,
       "merchantId": "M220EMX87XH1T",
       "token": token,
       "paymentMode": {"type": "PAY_PAGE"}
     };
     final request=jsonEncode(payload);

    try {
      var response = PhonePePaymentSdk.startTransaction(request,"myApp");
      response.then((val) => {
        navigate(val.toString(),orderId,amount,merchantId)
      })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }

    /*Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_live_MmKm1tIl8HM05R',
      'amount': amount,
      'name': 'F2DF.',
      'description': '',
      'orderId': orderId,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': appPreferences.mobile,
        'email': appPreferences.email
      },
      'external': {}
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);*/
  }
  void handleError(error) {

    if (error is Exception) {
      result = error.toString();
    } else {
      result = {"error": error.toString()} as String;
    }

  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    saveTransaction(0, response.code ?? 0, response.error.toString(),
        response.message ?? "", "", totalPrice.value, "", "", false);
    showAlertDialog(Get.context!, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    saveTransaction(0, 0, "", "", response.orderId ?? "", totalPrice.value,
        response.paymentId ?? "", response.signature ?? "", false);
    // Provider.of<CartNotifier>(Get.context!, listen: false).clearCart();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    Home.start(0);
    showAlertDialog(
        Get.context!, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void ShipRocketTransaction(
      String merchantTransectionId,String orderId,int totalAmount) async {
    final response = await apiServices.sendOrderToShipRocket(merchantTransectionId);
    if (response == null){

      Home.start(0);
      return;
    }
    if (response.status) {
      Common.showToast(response.message);
      cartController.updateresponse();
      Home.start(0);


      /*
      saveTransaction(0, 0, "", "", orderId ?? "", totalPrice.value,
          "","", false);*/
    }
  }
  void saveTransaction(
      int cartId,
      int code,
      String error,
      String message,
      String orderId,
      int paidAmount,
      String paymentId,
      String signature,
      status) async {
    final response = await apiServices.saveTransaction(
      cartId: cartId,
      code: code,
      error: error,
      message: message,
      orderId: orderId,
      paidAmount: paidAmount,
      paymentId: paymentId,
      signature: signature,
      status: status,
      userId: appPreferences.userId,
    );
    if (response == null) return;
    if (response.status == 200) {
      Common.showToast(response.message);
    }
  }
}
