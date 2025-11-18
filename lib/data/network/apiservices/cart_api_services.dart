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
import 'package:mcsofttech/models/productDetail/product_detail_model.dart';

import '../../../constants/Constant.dart';
import '../../../utils/common_util.dart';
import '../../preferences/AppPreferences.dart';
import '../dio_client.dart';

class CartApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<CommonModel?> addToCartApi({productId, quantity}) async {
    var inputData = {
      "productId": productId,
      "quantity": quantity,
      "userId": SharedConfig.userId
    };
    debugPrint('inputData: $inputData');
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/cart/add",
        data: jsonEncode(inputData),
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

  Future<CommonModel?> increaseQuantityApi({productId, quantity}) async {
    var inputData = {
      "userId": SharedConfig.userId,
      "productId": productId,
      "quantityToAdd": quantity
    };
    debugPrint('inputData: $inputData');

    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/cart/increase",
        data: jsonEncode(inputData),
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

  Future<CommonModel?> decreaseQuantityApi({productId, quantity}) async {
    var inputData = {
      "userId": SharedConfig.userId,
      "productId": productId,
      "quantityToDecrease": quantity
    };
    debugPrint('inputData: $inputData');

    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/cart/decrease",
        data: jsonEncode(inputData),
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

  Future<CommonModel?> deleteProductApi({cartUuid}) async {
    try {
      final response = await client.delete(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/cart/delete/${cartUuid}",
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

  Future<CartListResponse?> getCartList() async {
    try {

      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/cart/list/${appPreferences.userId}",

      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        return CartListResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<NewOrderResponse?> createOrderApi(
      {List<Map<String, dynamic>>? orderItems}) async {
    var inputData = {
      "userId": SharedConfig.userId,
      "shippingAddressId": SharedConfig.shippingAddressId,
      "orderItems": orderItems
      // [
      //     {
      //         "productId": 522,
      //         "quantity": 10
      //     }
      // ]
    };
    debugPrint('inputData: $inputData');

    NewOrderResponse? newOrder;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/api/orders/create",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('outPut: ${response.data}');
      }
      try {
        newOrder = NewOrderResponse.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return newOrder;
  }

  Future<CommonModel?> acceptDukanOrderApi({orderUuid}) async {
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

  Future<CommonModel?> rejectDukanOrderApi({orderUuid}) async {
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
