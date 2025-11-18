import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mcsofttech/models/category/categoryModel.dart';
import 'package:mcsofttech/models/category/subcategory/sub_Category.dart';
import 'package:mcsofttech/models/category/subcategory/subcat_drowse_model.dart';
import '../../../constants/Constant.dart';
import '../../../models/category/product_by_cat_id/product_by_cat_id.dart';
import '../../preferences/AppPreferences.dart';
import '../../preferences/shared_preferences.dart';
import '../dio_client.dart';

class CategoryApiServices extends DioClient {
  final client = DioClient.client;
  final appPreferences = Get.find<AppPreferences>();
  Future<CategoryModel?> categoryListApi({size = 100, page = 0}) async {
    var inputData = {"productType": "All"};
    CategoryModel? categoryModel;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/home/getAllCategory",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        categoryModel = CategoryModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return categoryModel;
  }

  Future<SubCategoryModel?> subCategoryListApi({catId}) async {
    var inputData = {"pc_id": catId};
    SubCategoryModel? subCategoryModel;
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/product-category/getCategory/$catId"
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        subCategoryModel = SubCategoryModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return subCategoryModel;
  }

  Future<ProductByCatIdModel?> categoryProductListApi(
      {catId, page, size}) async {
    var inputData = {"pc_id": catId};
    ProductByCatIdModel? productByCatIdModel;
    try {
      final response = await client.post(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/product/products-category",
        data: jsonEncode(inputData),
      );
      if (kDebugMode) {
        print('inputData: $inputData');
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

  Future<SubCatBrowseModel?> subCategoryBrowseListApi({catId}) async {
    Map<String, dynamic> queryParams = {
      "pc_id": catId,
    };
    var inputData = {"pc_id": catId};
    SubCatBrowseModel? subCatBrowseModel;
    try {
      final response = await client.get(
        options: Options(
          headers: {
            "Authorization": "Bearer ${appPreferences.authToken}",
          },
        ),
        "${Constant.baseUrl}/product-subcategory/getSubcategories/$catId"
      );
      if (kDebugMode) {
        debugPrint('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        subCatBrowseModel = SubCatBrowseModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return subCatBrowseModel;
  }
}
