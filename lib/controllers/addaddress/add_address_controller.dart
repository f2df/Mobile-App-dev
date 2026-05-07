import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mcsofttech/controllers/addaddress/address_list_controller.dart';
import '../../data/network/apiservices/address_services.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../models/address/AddressItem.dart';
import '../../ui/module/address/add_address.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class AddressController extends BaseController {
  final _apiService = Get.put(AddressApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader = false.obs;
  final RxList<AddressItem> addressListt = <AddressItem>[].obs;
  final nameController =TextEditingController();
  final mobileController =TextEditingController();
  final houseNoController =TextEditingController();
  final streetController =TextEditingController();
  final areaController =TextEditingController();
  final landmarkController =TextEditingController();
  final stateController =TextEditingController();
  final cityController =TextEditingController();
  final countryController =TextEditingController();
  final pincodeController =TextEditingController();
  final typeController =TextEditingController();
  RxList<String> userTypeList = ["Farmer","FPO","Business Entity"
  ].obs;
  late final Rx<String> selectTypeValue = userTypeList.first.obs;
  final List<AddressItem> addressList = [];
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
          addressListt.value.addAll(response.data);
          nameController.text=response.data[0].name??"";
          mobileController.text=response.data[0].mobile??"";
          houseNoController.text=response.data[0].houseNo??"";
          streetController.text=response.data[0].street??"";
          areaController.text=response.data[0].area??"";
          landmarkController.text=response.data[0].landmark??"";
          cityController.text=response.data[0].city??"";
          stateController.text=response.data[0].state??"";
          countryController.text=response.data[0].country??"";
          pincodeController.text=response.data[0].pincode??"";
        }
      }
    } catch (e) {
      Common.showToast("Something went wrong!");
      debugPrint(e.toString());
    }
  }
   void addAddress() async{
    if(nameController.text.toString().isEmpty){
      Common.showToast("Please enter user name");
      return;
    }
    if(mobileController.text.toString().isEmpty){
      Common.showToast("Please enter mobile");
      return;
    }
    if(houseNoController.text.toString().isEmpty){
      Common.showToast("Please enter house number");
      return;
    }
    if(streetController.text.toString().isEmpty){
      Common.showToast("Please enter street");
      return;
    }
    if(areaController.text.toString().isEmpty){
      Common.showToast("Please enter area");
      return;
    }
    if(landmarkController.text.toString().isEmpty){
      Common.showToast("Please enter landmark");
      return;
    }
    if(cityController.text.toString().isEmpty){
      Common.showToast("Please enter city");
      return;
    }
    if(stateController.text.toString().isEmpty){
      Common.showToast("Please enter state");
      return;
    }
    if(countryController.text.toString().isEmpty){
      Common.showToast("Please enter country");
      return;
    }
    if(pincodeController.text.toString().isEmpty){
      Common.showToast("Please enter pinCode");
      return;
    }
    /*if(typeController.text.toString().isEmpty){
      Common.showToast("Please enter landmark");
      return;
    }*/

    showLoader();
    isLoader.value=true;
    final response = await _apiService.addAddress(nameController.text.toString(),mobileController.text.toString(),houseNoController.text.toString(),streetController.text.toString(),areaController.text.toString(),landmarkController.text.toString(),stateController.text.toString(),cityController.text.toString(),countryController.text.toString(),pincodeController.text.toString(),appPreferences.userId,
        "");
    hideLoader();
    isLoader.value=false;
    if (response == null) Common.showToast("Something went wrong!");
    if (response?.status == 200) {
      Common.showToast(response?.message ?? "");
      appPreferences.savePinCode(pincodeController.text.toString());
      appPreferences.saveUserName(nameController.text.toString());
      appPreferences.saveHouseNo(houseNoController.text.toString());
      appPreferences.saveStreet(streetController.text.toString());
      appPreferences.saveArea(areaController.text.toString());
      appPreferences.saveLandmark(landmarkController.text.toString());
      appPreferences.saveCity(cityController.text.toString());
      appPreferences.saveState(stateController.text.toString());
      appPreferences.saveCountry(countryController.text.toString());
      if (Get.isRegistered<AddressListController>()) {
        Get.find<AddressListController>().callAddressApi();
      }
      Get.back();
    } else {
      Common.showToast(response?.message ?? "");
    }

  }
}