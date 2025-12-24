import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/ui/module/address/address_list.dart';
import '../../data/network/apiservices/address_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/address/AddressItem.dart';
import '../../ui/module/address/add_address.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class AddressListController extends BaseController {
  final _apiService = Get.put(AddressApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader = false.obs;
  final RxList<AddressItem> addressList = <AddressItem>[].obs;
@override
  void onInit() {
  callAddressApi();
    super.onInit();
  }
  void callAddressApi() async {
    isLoader.value = true;
    try {
      final response = await _apiService.getAddresList();

      isLoader.value = false;
      //if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == 200) {
        addressList.clear();
        if (response.data.isNotEmpty) {
          addressList.value.addAll(response.data);
        }else{
          Get.to(() => AddAddress.start("Add Address"))?.then((value) {
            // Called when Page2 is popped (Get.back)
            callAddressApi(); // reload your API, setState, etc.
          });

        }
      }
    } catch (e) {
      Common.showToast("Something went wrong!");
      debugPrint(e.toString());
    }
  }
}