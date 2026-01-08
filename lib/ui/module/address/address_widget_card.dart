import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/data/preferences/shared_preferences.dart';
import 'package:mcsofttech/models/address/AddressItem.dart';
import 'package:mcsofttech/theme/my_theme.dart';
import 'package:mcsofttech/ui/base/base_satateless_widget.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../utils/palette.dart';
import '../../commonwidget/text_style.dart';
import '../cart/cart_list_page.dart';

class AddressCard extends BaseStateLessWidget {
   AddressCard(
      {required this.addressData,
      super.key});

  final AddressItem addressData;
  final appPreferences = Get.find<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidget,
      child: InkWell(
        onTap: () {
          appPreferences.saveDelivaryAddress(true);
          SharedConfig.shippingAddressId=addressData.id;
          Get.back(result: true);
           },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: .5, color: MyColors.kColorGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(padding: const EdgeInsets.all(10),child: Column(children: [
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text(
                "Name",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                "${addressData.name}",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
              )
            ],),
            SizedBox(height: 10,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text(
                "Address",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                "${addressData.houseNo},${addressData.street},${addressData.area}",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
              )
            ],),
            SizedBox(height: 10,),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text(
                "LandMark",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                "addressData.landmark",
                style: TextStyles.headingTexStyle(
                  color: Palette.colorTextBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
              )
            ],),

          ],),),
        ),
      ),
    );
  }


}
