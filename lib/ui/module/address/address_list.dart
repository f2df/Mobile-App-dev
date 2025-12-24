import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/addaddress/add_address_controller.dart';
import '../../../controllers/addaddress/address_list_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart'; // Assuming this provides screenWidget and AppPageWithAppBar
import '../../commonwidget/primary_elevated_button.dart';
import '../../dialog/loader.dart';
import 'add_address.dart';
import 'address_widget_card.dart';

class AddressList extends AppPageWithAppBar {
  static String routeName = "/AddressList";

  AddressList({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title) {
    return navigateTo<bool>(routeName, currentPageTitle: title);
  }

  // Use Get.find() if this controller is initialized on a previous screen.
  // Using Get.put() here is acceptable if this is the first time it's used.
  final addressController = Get.put(AddressListController());
  final _scrollController = ScrollController();



  void setAtScroll() {
    _scrollController.addListener(() {
      // Logic for pagination (load more when scrolled to the end)
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !addressController.isLoader.value) { // Prevent calls while already loading

        // This assumes callAddressApi() fetches the next page and toggles isLoader.
        addressController.callAddressApi();
      }
    });
  }

  @override
  void onResume() {
    super.onResume();
    // Call API every time the screen becomes visible (e.g., returning from AddAddress)
    addressController.callAddressApi();
  }


  @override
  Widget get body {
    // Get the controller instance
    final AddressListController controller = Get.find<AddressListController>();

    return Obx(() {
      if (controller.isLoader.value && controller.addressList.value.isEmpty) {
        return const Loader();
      } else if (controller.addressList.value.isEmpty) {
        return Center(
          child: addAddress,
        );
      }

      // 1. Wrap the list content with RefreshIndicator
      return ListView.builder(
        controller: _scrollController,
        itemCount: controller.addressList.value.length + 1,
        itemBuilder: (context, index) {
          // ... your existing ListView.builder logic ...
          if (index == controller.addressList.value.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: addAddress,
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              width: screenWidget,
              child: AddressCard(addressData: controller.addressList.value[index]),
            ),
          );
        },
      );
    });
  }

  Widget get addAddress {
    return SizedBox(
      width: screenWidget,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PrimaryElevatedBtn(
          "Add Address",
              () => {
                navigateToAddAddress()
          },
          borderRadius: 40.0,
        ),
      ),
    );
  }
  void navigateToAddAddress() async {
    final result = await AddAddress.start("Add Address");
    if (result != null || result == null) {
      //addressController.callAddressApi();
    }
  }

// Note: Unused methods (row, textField) from the original code have been removed for a clean implementation.
}