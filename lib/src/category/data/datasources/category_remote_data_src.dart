import 'dart:io';

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
  Future<void> storeCategory(CategoryEntity category);
  Future<void> updateCategory({required int id, required SDMap updates});
  Future<void> deleteCategory(int id);
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

  @override
  Future<void> storeCategory(CategoryEntity category) async {
    try {
      await _apiService.sendMultipartRequest(
        method: ApiConst.post,
        url: ApiConst.categoriesUrl,
        body: (category as CategoryModel).toJson(),
        fieldName: 'icon',
        files: [File(category.icon!)],
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> updateCategory({required int id, required SDMap updates}) async {
    debugPrint('updateCategory from remote data source ....');

    if (updates.containsKey('icon')) {
      debugPrint('Starting sendMultipartRequest ....');

      final icon = updates.remove('icon') as File?;
      updates.addAll({'_method': ApiConst.patch});
      debugPrint('$updates');
      debugPrint('$icon');
      await _apiService.sendMultipartRequest(
        method: ApiConst.post,
        url: '${ApiConst.categoriesUrl}/$id',
        body: updates,
        fieldName: 'icon',
        files: [icon!],
      );
    } else {
      debugPrint('Starting patch request ....');

      await _apiService.patch(
        url: '${ApiConst.categoriesUrl}/$id',
        body: updates,
      );
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await _apiService.delete(url: '${ApiConst.categoriesUrl}/$id');
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
