import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/models/common_message_model.dart';
import 'package:mcsofttech/models/login/login_model_first.dart';
import '../../../constants/Constant.dart';
import '../../../models/message_status_model.dart';
import '../../preferences/AppPreferences.dart';
import '../../preferences/shared_preferences.dart';
import '../dio_client.dart';

class ProfileApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<CommonModel?> profileApi(
      {mobile,
      email,
      username,
      userType,
      address,
      userId,
      address1,
      address2,
      city,
      state,
      pincode,token}) async {
    late CommonModel? commonResponseModel;
    var inputData = {
      "mobile": mobile,
      "email": email,
      "name": username,
      "userType":userType,
      "id": userId,
      "address": {
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": "India",
        "pincode": pincode
      }
    };
    debugPrint('inputData: ${jsonEncode(inputData).toString()}');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        "${Constant.baseUrl}/saveUser",
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

  Future<CommonResponseModel?> uploadImage(
      {fileContentBase64, fileName, userId}) async {
    late CommonResponseModel? commonResponseModel;
    var inputData = {
      "fileContentBase64": fileContentBase64,
      "fileName": fileName,
      "userId": userId
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/uploadImage",
        data: inputData,
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        commonResponseModel = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return commonResponseModel;
  }

  Future<LoginFirstModel?> getProfileApi({id,authToken}) async {
    var inputData = {"id": id};
    debugPrint('inputData: $inputData');
    LoginFirstModel? loginModel;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer $authToken",
          },
        ),
        "${Constant.baseUrl}/getProfile",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginFirstModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
}
