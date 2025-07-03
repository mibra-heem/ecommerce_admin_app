import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/services/api_service.dart';
import 'package:ecommerce_admin_app/src/category/data/models/category_model.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:flutter/material.dart';

abstract class CategoryRemoteDataSrc {
  const CategoryRemoteDataSrc();
  Future<List<CategoryEntity>> getCategories();
}

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSrc {
  const CategoryRemoteDataSrcImpl(ApiService apiService)
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final data = await _apiService.get(url: ApiConst.categoriesUrl);

      debugPrint('Categories Data : $data');

      final categories = data['categories'] as List<dynamic>;

      return categories
          .map((category) => CategoryModel.fromJson(category as SDMap))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
