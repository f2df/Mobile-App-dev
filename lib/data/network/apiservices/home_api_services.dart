import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/data/network/dio_client.dart';
import 'package:mcsofttech/models/home/home_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/category/product_by_cat_id/product_by_cat_id.dart';
import '../../../models/common_message_model.dart';
import '../../../models/export/add_requirenment_input_model.dart';
import '../../preferences/AppPreferences.dart';
import '../../preferences/shared_preferences.dart';

class HomeApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();


  Future<HomeModel?> homeListApi({size = 10, page = 0}) async {
    var inputData = {"size": size, "page": page ?? 0};
    HomeModel? homeModel;
    try {
      debugPrint('token: Bearer ${appPreferences.authToken.trim()}');
      final response = await client.post(
        "${Constant.baseUrl}/home/homeApi",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        debugPrint('inputData: $inputData');
        debugPrint('outPut: ${response.data}');
      }
      try {
        homeModel = HomeModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {}
    return homeModel;
  }

  Future<ProductByCatIdModel?> productListFromHomeApi(
      {size = 10, page = 0, type}) async {
    var inputData = {"size": size, "page": page, "home": type};
    ProductByCatIdModel? productByCatIdModel;
    debugPrint('inputData:Bearer ${appPreferences.authToken.trim()}');
    try {
      final response = await client.post(
        "${Constant.baseUrl}/product/products",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        productByCatIdModel = ProductByCatIdModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return productByCatIdModel;
  }
  Future<CommonResponseModel?> addRequirementApi(
      String show,
      String productName,
      String name,
      String phoneNumber,
      String location,
      String offerPrice,
      String quantity,
      String expectedDate) async {
    String inputData = jsonEncode(AddRequirementInputModel(
        show: show,
        productName: productName,
        name: name,
        phoneNumber: phoneNumber,
        location: location,
        offerPrice: offerPrice,
        quantity: quantity,
        expectedDate: expectedDate));

    debugPrint('inputData: $inputData');
    CommonResponseModel? data;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/addSellerReq",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        data = CommonResponseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
}
