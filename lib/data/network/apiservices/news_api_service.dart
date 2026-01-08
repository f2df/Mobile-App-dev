import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/Constant.dart';
import '../../../models/login/login_input_model.dart';
import '../../../models/login/login_model.dart';
import '../../../models/newandvideo/NewDetailModel.dart';
import '../../preferences/AppPreferences.dart';
import '../../preferences/shared_preferences.dart';
import '../dio_client.dart';

class NewsApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<NewDetailModel?> newsApi(int pageNo, int size,String type) async {

    String inputData = jsonEncode({"pageNo":pageNo,"size":size,"type":"news"});
    debugPrint('inputData: $inputData');
    NewDetailModel? newDetailModel;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/news/getAllNews",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        newDetailModel = NewDetailModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return newDetailModel;
  }
  Future<NewDetailModel?> videoApi(int pageNo, int size,String type) async {

    String inputData = jsonEncode({"pageNo":pageNo,"size":size,"type":"Video"});
    debugPrint('inputData: $inputData');
    NewDetailModel? newDetailModel;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/news/getAllVideoNews",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        newDetailModel = NewDetailModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return newDetailModel;
  }


}
