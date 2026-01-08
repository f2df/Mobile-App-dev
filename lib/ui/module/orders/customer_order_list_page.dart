import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';
import 'package:mcsofttech/controllers/orders/customer_order_controller.dart';
import 'package:mcsofttech/controllers/orders/vendor_order_controller.dart';
import 'package:mcsofttech/data/preferences/AppPreferences.dart';
import 'package:mcsofttech/models/order/orderListResponse.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:mcsofttech/ui/commonwidget/primary_elevated_button.dart';
import 'package:mcsofttech/ui/dialog/loader.dart';
import 'package:mcsofttech/ui/module/orders/order_details_page.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../services/navigator.dart';
import '../../commonwidget/text_style.dart';

class CustomerOrderListpage extends AppPageWithAppBar {
  static String routeName = "/customerOrderListpage";
  CustomerOrderListpage({Key? key}) : super(key: key);
  static Future<bool?> start<bool>(
    String title,
  ) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final controller = Get.put(CustomerOrderController());
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
              children: List.generate(
                  controller.orderList.length,
                  (i) => InkWell(
                      onTap: () => OrderDetailsPage.start("Order Details",
                          controller.orderList[i].orderUUid ?? ""),
                      child: OrderCard(product: controller.orderList[i]))),
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
  final controller = Get.find<CustomerOrderController>();
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
                    (index) =>
                        product.itemList?[index].productName?.isNotEmpty ??
                                false
                            ? Row(
                                children: [
                                  Text(
                                      "${product.itemList?[index].productName ?? ""} X ${product.itemList?[index].quantity ?? ""}"),
                                  Spacer(),
                                  Text(
                                      "\u{20B9} ${product.itemList?[index].price ?? ""}")
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

  Widget get orderDate {
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
}
