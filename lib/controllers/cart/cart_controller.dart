import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/controllers/meridhukaan/total_visitor_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:mcsofttech/utils/common_util.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../ui/module/address/add_address.dart';
import '../meridhukaan/add_user_action_controller.dart';

class CartController extends BaseController {
  final apiServices = Get.put(CartApiServices());
  final isLoader = false.obs;
  final cartCount = 0.obs;
  final pQuantity = 0.obs;
  final cartList = <Equiry>[].obs;
  List<Equiry> dataList = [];
  final totalValue = 0.obs;
  final appPreferences = Get.find<AppPreferences>();
  final userActionController = Get.put(AddUserActionController());
  final quantity = 0.obs;
  @override
  void onInit() {
    super.onInit();
    updateresponse();
  }

  void addItems(String productId, int quantity,{product}) async {
    if(appPreferences.pinCode.isEmpty){
      AddAddress.start("Add Address");

    }else{
      showLoader();

      final serviceAbility=await apiServices.checkServiceability(p_id: productId,delivary_Id: appPreferences.pinCode,code: 1);
      if(!(serviceAbility?.data!.serviceable ?? false)){
        hideLoader();
        Common.showToast(serviceAbility?.message??"Unavailable service please change you pinCode");
        AddAddress.start("Add Address");
        return;
      }
      final response = await apiServices.addToCartApi(
          productId: productId, quantity: quantity);
      hideLoader();
      if (response != null && response.status == 200) {
        updateresponse();
      }
    }

  }

  void increaseQuantity(String productId, int quantity) async {
    showLoader();
    final response = await apiServices.increaseQuantityApi(
        productId: productId, quantity: quantity);
    hideLoader();
    //if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      updateresponse();
    }
  }

  void decreaseQuantity(String productId, int quantity,int actualQuantity) async {
    showLoader();
    final response = await apiServices.decreaseQuantityApi(
        productId: productId, quantity: quantity);
    hideLoader();
    //if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      updateresponse();
    }
  }

  void deleteItem(String cartUuid) async {
    showLoader();
    final response = await apiServices.deleteProductApi(cartUuid: cartUuid);
    hideLoader();
    //if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      updateresponse();
    }
  }

  void updateresponse() async {
    final response = await apiServices.getCartList();
    if (response == null) return;
    if (response.data?.cartItems?.isNotEmpty ?? false) {

      cartList.value =response.data!.cartItems!;
      totalValue.value = response.data?.totalPrice ?? 0;
      cartCount.value = cartList.length;
      if(totalValue.value<0){
        cartList.value =[];
        cartCount.value=0;
      }
      if(totalValue.value==0){
        deleteItem(cartList[0].uuid);
      }
      final cont=Get.put(TotalVisitorController());
      cont.equiryList.value=cartList.value;
      cont.totalPrice;

    }else{
      cartList.value =[];
      cartCount.value=0;
      //Get.back();
    }
  }
  void getList() async {
    isLoader.value=true;
    final response = await apiServices.getCartList();
    isLoader.value=false;
    if (response == null) return;
    if (response.data?.cartItems?.isNotEmpty ?? false) {

      cartList.value =response.data!.cartItems!;
      totalValue.value = response.data?.totalPrice ?? 0;
      cartCount.value = cartList.length;
      if(totalValue.value<0){
        cartList.value =[];
        cartCount.value=0;
      }
      if(totalValue.value==0){
        deleteItem(cartList[0].uuid);
      }
      final cont=Get.put(TotalVisitorController());
      cont.equiryList.value=cartList.value;
      cont.totalPrice;

    }else{
      cartList.value =[];
      cartCount.value=0;
      //Get.back();
    }
  }
  int getQuanity(prod){
    if(cartList.isNotEmpty){
      print(quantity.value);
      return quantity.value = cartList.where((p0) => p0.product_id==prod).lastOrNull?.qunatity ?? 0;

    }
    return 0;


  }
}
