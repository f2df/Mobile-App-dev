import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/addaddress/add_address_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonwidget/primary_elevated_button.dart';

class AddAddress extends AppPageWithAppBar {
  static String routeName = "/AddAddress";

  AddAddress({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title,) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  final addressController = Get.put(AddressController());
  final appPreferences = Get.find<AppPreferences>();

  @override
  Widget get body {
    addressController.nameController.text=appPreferences.userName.toString();
    addressController.mobileController.text=appPreferences.mobile.toString();
    addressController.houseNoController.text=appPreferences.houseNo.toString();
    addressController.streetController.text=appPreferences.street.toString();
    addressController.areaController.text=appPreferences.area.toString();
    addressController.landmarkController.text=appPreferences.landmark.toString();
    addressController.cityController.text=appPreferences.city.toString();
    addressController.stateController.text=appPreferences.state.toString();
    addressController.countryController.text=appPreferences.country.toString();
    addressController.pincodeController.text=appPreferences.pinCode.toString();
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
    SliverList(
    delegate: SliverChildListDelegate([
      Padding(padding: const EdgeInsets.only(left: 10,right: 10),child: Column(children: [
        const SizedBox(height: 20),
        textField("Enter name", addressController.nameController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter mobile", addressController.mobileController, TextInputType.number),
        const SizedBox(height: 10),
        textField("Enter house number", addressController.houseNoController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter street", addressController.streetController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter Area", addressController.areaController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter Landmark", addressController.landmarkController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter City", addressController.cityController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter State", addressController.stateController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter Country", addressController.countryController, TextInputType.text),
        const SizedBox(height: 10),
        textField("Enter PinCode", addressController.pincodeController, TextInputType.number),
        const SizedBox(height: 10),
        updateButton,
        const SizedBox(height: 20),
      ],),)
    ])),

      ],
    );
  }

  Widget get updateButton {
    return SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn(
          appPreferences.pinCode.isEmpty?"Save":"Edit",
              () =>
          {addressController.addAddress()},
          borderRadius: 40.0),
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
