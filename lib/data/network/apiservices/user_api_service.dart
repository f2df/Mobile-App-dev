import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../models/login/LoginData.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../../../models/login/login_model_first.dart';
import '../dio_client.dart';

class UserDashboardApiServices extends DioClient {
  final client = DioClient.client;

  Future<LoginFirstModel?> loginApi(String userId) async {
    String inputData = jsonEncode({"userId": userId});
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
}
