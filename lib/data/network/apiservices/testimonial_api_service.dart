import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/models/testimonial/Tesiminial_model.dart';
import '../../../constants/Constant.dart';
import '../../preferences/AppPreferences.dart';
import '../../preferences/shared_preferences.dart';
import '../dio_client.dart';

class TestimonialApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<TestimonialModel?> testimonialApi() async {

    TestimonialModel? testimonialModel;
    var inputData = {};
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/home/testimonial",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('outPut: ${response.data}');

      }
      try {
        testimonialModel = TestimonialModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return testimonialModel;
  }
}
