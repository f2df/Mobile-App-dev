import 'package:get/get.dart';
import 'package:mcsofttech/controllers/base_getx_controller.dart';
import 'package:mcsofttech/data/network/apiservices/order_api_service.dart';
import 'package:mcsofttech/models/order/orderListResponse.dart';
import 'package:mcsofttech/utils/common_util.dart';

class VendorOrderController extends BaseController {
  final apiService = Get.put(OrderApiService());
  final orderList = <OrderList>[].obs;
  final isLoader = false.obs;
  @override
  void onInit() {
    super.onInit();
    callProductListApi();
  }

  void callProductListApi() async {
    isLoader(true);
    final response = await apiService.vendorOrdersListApi();
    isLoader(false);
    if (response == null) Common.showToast("Something went wrong!");
    if (response != null &&
        response.status == 200 &&
        response.orderList != null &&
        response.orderList!.isNotEmpty) {
      orderList.value = response.orderList ?? [];
    }
  }

  void callAcceptApi(String orderUuid) async {
    showLoader();
    final response = await apiService.acceptOrderApi(orderUuid: orderUuid);
    hideLoader();
    if (response == null) Common.showToast("Something went wrong!");
    if (response != null &&
        response.status == 200 &&
        response.message.isNotEmpty) Common.showToast(response.message);
  }

  void callRejectApi(String orderUuid) async {
    showLoader();
    final response = await apiService.rejectOrderApi(orderUuid: orderUuid);
    hideLoader();
    if (response == null) Common.showToast("Something went wrong!");
    if (response != null &&
        response.status == 200 &&
        response.message.isNotEmpty) Common.showToast(response.message);
  }
}
