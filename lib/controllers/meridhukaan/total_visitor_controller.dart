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
        equiryList.value = response.equiryList;
       totalPrice.value = 0;
       totalPrice.value = response.totalPrice;
     }
  }

  Future<void> createOrderId(amount, List<Map<String, dynamic>> items) async {

    showLoader();
    final response = await cartApiServices.createOrderApi(orderItems: items);

    hideLoader();
    if (response == null) return;
    if (response.statusCode == 200) {
      debugPrint("sonu${response.data} ::${amount * 100}");
      buyNow(Common.getRandomNumber().toString(), amount * 100);
    } else {
      Common.showToast(response.message ?? "");
    }
  }

  Future<void> createOrderIdForBook(amount) async {
    showLoader();
    final response = await apiServices.orderCreate(paidAmount: amount);
    hideLoader();
    if (response == null) return;
    if (response.status == 200) {
      debugPrint("sonu${response.data} ::${amount * 100}");
      buyNow(response.data, amount * 100);
    } else {
      Common.showToast(response.message);
    }
  }
  String getSalt(String orderId,int amount) {

    String apiEndPoint = "/pg/v1/pay";
    var salt = "6ecedc1a-eed9-454b-9a07-5fd33d49dc5d";
    var index = 1;
    return "${sha256
        .convert(utf8.encode(getBody(orderId,amount,transaction) + apiEndPoint + salt))}###$index";
  }

  String getBody(String orderId,int amount,String transaction) {

    var body = {
      "merchantId": "M220EMX87XH1T",
      "merchantTransactionId": transaction,
      "merchantUserId": appPreferences.userId,
      "amount": 1000,
      "mobileNumber": appPreferences.mobile,
      "callbackUrl": "https://webhook.site/fb8f7b18-790f-4106-80cc-7ea57961dc86",
      "paymentInstrument": {"type": "PAY_PAGE"}
    }; // Encode the request body to JSON
    String jsonBody = jsonEncode(body);
    String base64EncodedBody = base64Encode(utf8.encode(jsonBody));
    return base64EncodedBody;
  }
  void navigate(String result,String orderId){
    if(result.contains("SUCCESS")){
      saveTransaction(0, 0, "", "", orderId ?? "", totalPrice.value,
          "","", false);

    }else{
      Common.showToast(result);
    }
    Home.start(0);
  }
  void buyNow(String orderId, int amount) {
     String value=getSalt(orderId,amount);
    try {
      var response = PhonePePaymentSdk.startTransaction(
          getBody(orderId,amount,transaction), "https://webhook.site/fb8f7b18-790f-4106-80cc-7ea57961dc86", value, "com.f2df.mcsofttech");
      response.then((val) => {
        navigate(val.toString(),orderId)


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
