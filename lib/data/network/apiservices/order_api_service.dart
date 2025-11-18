import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/data/preferences/shared_preferences.dart';
import 'package:mcsofttech/models/cart/new_order.dart';
import 'package:mcsofttech/models/meridukaan/userdashboard/Equiry.dart';
import 'package:mcsofttech/models/message_status_model.dart';
import 'package:mcsofttech/models/order/orderListResponse.dart';
import 'package:mcsofttech/models/productDetail/product_detail_model.dart';

import '../../../constants/Constant.dart';
import '../../../utils/common_util.dart';
import '../../preferences/AppPreferences.dart';
import '../dio_client.dart';

class OrderApiService extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<OrderListResponse?> vendorOrdersListApi() async {
    var inputData = {"userId": SharedConfig.userId};
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/getVenderOrder",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return OrderListResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<OrderListResponse?> customerOrdersListApi() async {
    var inputData = {"userId": SharedConfig.userId};
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/getCustomerOrder",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return OrderListResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<OrderListResponse?> customerOrderDetailApi({orderUuid}) async {
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/getOrderDetails/$orderUuid",
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return OrderListResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CommonModel?> acceptOrderApi({orderUuid}) async {
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/accept-dukan-order/$orderUuid",
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CommonModel?> rejectOrderApi({orderUuid}) async {
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/reject-dukan-order/$orderUuid",
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CommonModel?> cancelUserOrderApi({orderUuid}) async {
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/cancel-user-order/$orderUuid",
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return CommonModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
