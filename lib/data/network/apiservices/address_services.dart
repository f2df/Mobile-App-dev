import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/data/preferences/shared_preferences.dart';

import '../../../constants/Constant.dart';
import '../../../models/address/Address_list_model.dart';
import '../../../models/message_status_model.dart';
import '../../preferences/AppPreferences.dart';
import '../dio_client.dart';

class AddressApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<CommonModel?> addAddress(String name,String mobile,String houseNo,String street,String area,String landmark,String state,
      String city,String country,String pincode,String userId,String type) async {
    var inputData = {
      "name": name,
      "mobile": mobile,
      "houseNo": houseNo,
      "street":street,
      "area": area,
      "landmark":landmark,
      "state":state,
      "city":city,
      "country":country,
      "pincode":pincode,
      "userId":userId,
      "type":type,
      "selected":true

    };
    late CommonModel? commonResponseModel;
    debugPrint('inputData: ${jsonEncode(inputData).toString()}');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/addDeliveryAddress",
        data: jsonEncode(inputData).toString(),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return commonResponseModel;
  }
Future<AddressListModel?> getAddresList()async{
  var inputData = {
    "userId": SharedConfig.userId,

  };
  late AddressListModel? commonResponseModel;
  debugPrint('inputData: ${jsonEncode(inputData).toString()}');
  try {
    final response = await client.post(
      options: Options(
        headers: {
          "Authorization": "Bearer ${appPreferences.authToken}",
        },
      ),
      "${Constant.baseUrl}/getDeliveryAddress",
      data: jsonEncode(inputData).toString(),
    );
    if (kDebugMode) {
      print('outPut: ${response.data}');
    }
    try {
      commonResponseModel = AddressListModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return commonResponseModel;

}
}
