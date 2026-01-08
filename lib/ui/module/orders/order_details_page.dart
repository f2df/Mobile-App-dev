import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';
import 'package:mcsofttech/controllers/orders/customer_order_controller.dart';
import 'package:mcsofttech/controllers/orders/order_details_controller.dart';
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

class OrderDetailsPage extends AppPageWithAppBar {
  static String routeName = "/orderDetailsPage";
  OrderDetailsPage({super.key}) {
    controller = Get.put(OrderDetailsController(orderUuid: arguments));
  }
  static Future<bool?> start<bool>(
    String title,
    String orderUuid,
  ) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title, arguments: orderUuid);
  }

  late OrderDetailsController controller;
  final appPreference = Get.find<AppPreferences>();

  @override
  Widget get body {
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : SafeArea(
            child: Stack(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 0),
                    child: controller.orderList.isNotEmpty
                        ? cartList
                        : const SizedBox.shrink()),
                Positioned(bottom: 0, child: cancelButton)
              ],
            ),
          ));
  }

  Widget get cancelButton {
    return SizedBox(
      width: screenWidget,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: PrimaryElevatedBtn("Cancel Order".tr, controller.cancelOrder,
                borderRadius: 1.0),
          )),
    );
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
              child: orderDetails(controller.orderList.first)),
        ],
      ),
    );
  }

  Widget orderDetails(OrderList product) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderDate(product),
              const SizedBox(height: 10),
              Text("Delivery address : ${product.deliveryAddress.toString()}",
                  style: TextStyles.headingTexStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: "assets/font/Oswald-Regular.ttf")),
              const SizedBox(height: 10),
              Text("${product.itemList?.length ?? 0} items",
                  style: TextStyles.headingTexStyle(
                      fontSize: 14,
                      fontFamily: "assets/font/Oswald-Regular.ttf")),
              const SizedBox(height: 10),
              ...List.generate(
                  product.itemList?.length ?? 0,
                  (index) => product.itemList?[index].productName?.isNotEmpty ??
                          false
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${product.itemList?[index].productName ?? ""} X ${product.itemList?[index].quantity ?? ""}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Price: \u{20B9} ${product.itemList?[index].price ?? ""}"),
                                const SizedBox(height: 10),
                                Text(
                                  product?.itemList?[index].status ?? "",
                                  style: TextStyle(
                                      color: statusTextColor(
                                          product?.itemList?[index].status)),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox.shrink()),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderDate(OrderList product) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text("${product.oderDate ?? ""}",
                style: TextStyles.headingTexStyle(
                    fontSize: 14,
                    fontFamily: "assets/font/Oswald-Regular.ttf")),
          ),
          Text("Order Amount:\u{20B9} ${product.totalPrice ?? 0}",
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
