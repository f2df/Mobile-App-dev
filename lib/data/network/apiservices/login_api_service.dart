import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/Constant.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../../../models/login/login_model_first.dart';
import '../../preferences/AppPreferences.dart';
import '../dio_client.dart';

class LoginApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<LoginFirstModel?> loginApi(String mobile, String loginId,bool termAndCondition) async {
    String type = "mobile";
    if (mobile.toString().isEmpty) {
      type = "gmail";
    }
    String inputData = jsonEncode(
        LoginInputModel(mobile: mobile, googleId: loginId, type: type,termAndCondition:termAndCondition));

    debugPrint('inputData: $inputData');
    LoginFirstModel? loginModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/login",
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

  Future<LoginModel?> otpApi({mobile, otp, refferalCode}) async {
    var inputData = {
      "mobile": mobile ?? "",
      "otp": otp ?? "",
      "refferalCode": refferalCode ?? ""
    };
    debugPrint('inputData: $inputData');
    LoginModel? loginModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/verifyOTP",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }

  Future<LoginModel?> getProfileApi({id}) async {
    var inputData = {"id": id};
    debugPrint('inputData: $inputData');
    LoginModel? loginModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/getProfile",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
}
