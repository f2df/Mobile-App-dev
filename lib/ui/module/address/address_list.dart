import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/addaddress/add_address_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonwidget/primary_elevated_button.dart';
import '../../dialog/loader.dart';
import 'add_address.dart';
import 'address_widget_card.dart';

class AddressList extends AppPageWithAppBar {
  static String routeName = "/AddressList";

  AddressList({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title,) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final addressController = Get.put(AddressController());
  final _scrollController = ScrollController();

  void setAtScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        addressController.isLoader.value = false;
        addressController.callAddressApi();
      }
    });
  }
  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    setAtScroll();
  }
  @override
  Widget get body {
    setAtScroll();
    addressController.callAddressApi();
    return Obx(() => addressController.isLoader.value
        ? const Loader()
        : addressController.addressList.isNotEmpty
        ? SingleChildScrollView(
        controller: _scrollController, child: container)
        :  Center(
      child: addAddress,
    ));
  }
  Widget get container {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: Wrap(
            spacing: 5,
            children: addressList,
          ),
        ),
      ],
    );


  }
  List<Widget> get addressList {
    List<Widget> list = [];
    for (int i = 0; i <= addressController.addressList.length-1; i++) {
      list.add(SizedBox(
          height: 110,
          child: SizedBox(
            width: screenWidget,
            child:  AddressCard(addressData: addressController.addressList[i],),
          )));
      if(i==addressController.addressList.length-1){
        list.add(addAddress);
      }


    }
    return list;
  }
  Widget get addAddress {
    return SizedBox(
      width: screenWidget,
      height: 60,
      child: Padding(padding: EdgeInsets.all(10),child: PrimaryElevatedBtn(
          "Add Address",
              () =>
          {
            AddAddress.start("Add Address")
          },
          borderRadius: 40.0),),
    );
  }
  Widget get row{
    return Row(children: [
      SizedBox(
        width: screenWidget/2,
        height: 45,
        child: PrimaryElevatedBtn(
            "Check PinCode",
                () =>
            {addressController.addAddress()},
            borderRadius: 40.0),
      )
    ],);
  }


  Widget textField(String hint, TextEditingController controller,
      TextInputType textInputType) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(20),
        fillColor: Colors.white,
      ),
    );
  }
}
