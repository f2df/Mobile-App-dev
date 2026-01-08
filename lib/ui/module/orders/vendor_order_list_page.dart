import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';
import 'package:mcsofttech/controllers/orders/vendor_order_controller.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/order/orderListResponse.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/primary_elevated_button.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/utils/palette.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../services/navigator.dart';
import '../../commonwidget/text_style.dart';

class VendorOrderListPage extends AppPageWithAppBar {
  static String routeName = "/vendorOrderListPage";
  VendorOrderListPage({Key? key}) : super(key: key);
  static Future<bool?> start<bool>(
    String title,
  ) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final controller = Get.put(VendorOrderController());
  final appPreference = Get.find<AppPreferences>();

  @override
  Widget get body {
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 0),
                child: controller.orderList.isNotEmpty
                    ? cartList
                    : const SizedBox.shrink()),
          ));
  }

  Widget get cartList {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: screenHeight / 1.2,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(controller.orderList.length,
                  (i) => OrderCard(product: controller.orderList[i])),
            ),
          )
        ],
      ),
    );
  }
}

class OrderCard extends BaseStateLessWidget {
  final OrderList product;

  OrderCard({Key? key, required this.product}) : super(key: key);
  final controller = Get.find<VendorOrderController>();
  final quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    return createCartListItem();
  }

  Widget createCartListItem() {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderDate,
                const SizedBox(height: 10),
                Text("${product.itemList?.length ?? 0} items",
                    style: TextStyles.headingTexStyle(
                        fontSize: 14,
                        fontFamily: "assets/font/Oswald-Regular.ttf")),
                ...List.generate(
                    product.itemList?.length ?? 0,
                    (index) => product
                                ?.itemList?[index].productName?.isNotEmpty ??
                            false
                        ? Column(
                            children: [
                              Text(product?.itemList?[index].productName ?? ""),
                              SizedBox(height: 10),
                              Text(
                                product?.itemList?[index].status ?? "",
                                style: TextStyle(
                                    color: statusTextColor(
                                        product?.itemList?[index].status)),
                              ),
                              SizedBox(height: 10),
                              getAcceptRejectButton(
                                  product?.itemList?[index].orderUUid ?? "")
                            ],
                          )
                        : SizedBox.shrink()),
                const SizedBox(height: 10),
                Text("Delivery address : ${product.deliveryAddress.toString()}",
                    style: TextStyles.headingTexStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: "assets/font/Oswald-Regular.ttf")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getAcceptRejectButton(String itemUuid) {
    return Row(
      children: [
        PrimaryElevatedBtn("Accept", () => controller.callAcceptApi(itemUuid)),
        SizedBox(
          width: 20,
        ),
        PrimaryElevatedBtn("Reject", () => controller.callRejectApi(itemUuid))
      ],
    );
  }

  Widget get orderDate {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text("Order date: ${product.oderDate ?? ""}",
                style: TextStyles.headingTexStyle(
                    fontSize: 14,
                    fontFamily: "assets/font/Oswald-Regular.ttf")),
          ),
          Text("Order Amount: ${product.totalPrice ?? 0}",
              style: TextStyles.headingTexStyle(
                  fontSize: 14, fontFamily: "assets/font/Oswald-Regular.ttf")),
        ],
      ),
    );
  }

  Color statusTextColor(String? status) {
    if (status?.isEmpty ?? false) return Palette.kColorGold;
    switch (status) {
      case "Pending":
        return Palette.kColorGold;
      case "Accepted":
        return Palette.kColorGreen;
      case "Rejected":
        return Palette.kColorRed;
      default:
        return Palette.kColorGold;
    }
  }
}
