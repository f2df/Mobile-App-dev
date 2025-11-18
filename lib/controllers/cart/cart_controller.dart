import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/cart_api_services.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:mcsofttech/notifire/cart_notifire.dart';
import 'package:mcsofttech/utils/common_util.dart';
import 'package:provider/provider.dart';

class CartController extends BaseController {
  final apiServices = Get.put(CartApiServices());
  final isLoader = false.obs;
  final cartCount = 0.obs;
  final cartList = <Equiry>[].obs;
  final totalValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
    updateresponse();
  }

  void addItems(String productId, int quantity) async {
    showLoader();
    final response = await apiServices.addToCartApi(
        productId: productId, quantity: quantity);
    hideLoader();

    //if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == 200) {
      updateresponse();
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

  void decreaseQuantity(String productId, int quantity) async {
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
      cartList.value = response.data?.cartItems ?? [];
      totalValue.value = response.data?.totalPrice ?? 0;
      cartCount.value = cartList.length;
    }else{
      cartList.value =[];
      cartCount.value=0;
      Get.back();
    }
  }
}
