import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/cart/cart_controller.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import '../../../constants/Constant.dart';
import '../../../controllers/meridhukaan/total_visitor_controller.dart';
import '../../../utils/palette.dart';
import '../../base/base_satateless_widget.dart';
import '../../commonwidget/text_style.dart';

class KartCard extends BaseStateLessWidget {
  final Equiry product;
  final wishController = Get.find<TotalVisitorController>();

  KartCard({Key? key, required this.product}) : super(key: key);
  final controller = Get.find<CartController>();

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
            Row(
              children: [
                productImage,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productName,
                    price,
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [incrementCount, delete],
            )
          ],
        ),
      ),
    );
  }

  Widget get price {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 10, top: 10),
      child: Row(
        children: [
          Text("\u{20B9} ${product.actualPrice }",
              style: TextStyles.headingTexStyle(
                  fontSize: 12,
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Regular.ttf")),
          const SizedBox(
            width: 5,
          ),
          Text("\u{20B9} ${product.productOldFee}",
              style: TextStyles.headingTexStyle(
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                  color: Palette.kColorRed,
                  fontFamily: "assets/font/Oswald-Regular.ttf"))
        ],
      ),
    );
  }

  Widget get incrementCount {
    return Container(
      width: 130,
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Palette.colorWhite),
          borderRadius: BorderRadius.circular(10),
          color: Palette.kColorExtraLightBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                if(product.qunatity==1){
                  controller.deleteItem(product.uuid);
                }else if(product.qunatity>0){
                  controller.decreaseQuantity(product.product_id.toString(), 1,product.qunatity);
                }},
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Palette.kColorDarkGrey,
                size: 20,
              )),
          const SizedBox(
            width: 7,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: SizedBox(
              width: 40,
              child: Text(
                product.qunatity.toString(),
                textAlign: TextAlign.center,
                style: TextStyles.headingTexStyle(color: Palette.appColor),
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          InkWell(
              onTap: () {
                controller.increaseQuantity(product.product_id.toString(), 1);
              },
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyles.headingTexStyle(
                    color: Palette.appColor, fontWeight: FontWeight.w900),
              )),
          const SizedBox(
            width: 7,
          ),
        ],
      ),
    );
  }

  Widget get delete {
    return InkWell(
      onTap: () {
        controller.deleteItem(product.uuid);
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Palette.kColorExtraLightBlack),
            borderRadius: BorderRadius.circular(10),
            color: Palette.kColorWhite),
        child: const Padding(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Text("Delete",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Palette.kColorBlack)),
        ),
      ),
    );
  }

  Widget get addAndMinButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            onPressed: () {
              controller.increaseQuantity(product.product_id.toString(), 1);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1), color: Palette.colorWhite),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(product.qunatity.toString(),
                style: const TextStyle(fontSize: 15.0)),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            onPressed: () {
              controller.decreaseQuantity(product.product_id.toString(), 1,0);
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget get productName {
    return Container(
      width: screenWidget / 2,
      padding: const EdgeInsets.only(right: 10, top: 0),
      child: Text(
        product.productName,
        maxLines: 2,
        softWrap: true,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget get productImage {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 2, top: 8, bottom: 15),
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/png/app_logo.png',
          image: "${Constant.baseImageUrl}${product.productImg}",
          fit: BoxFit.cover,
          height: 40.0,
        ),
      ),
    );
  }

  Widget get removeFromCart {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          controller.deleteItem(product.uuid);
        },
        child: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }

  int getPrice(int price, int quantity) {
    int totalPrice = (price * quantity);
    return totalPrice;
  }
}
