import 'dart:io';

import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/services/api_service.dart';
import 'package:ecommerce_admin_app/src/product/data/models/product_model.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

abstract class ProductRemoteDataSrc {
  const ProductRemoteDataSrc();
  Future<List<Product>> getProducts();
  Future<void> storeProduct(Product product);
  Future<void> updateProduct({required String id, required SDMap updates});
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSrcImpl implements ProductRemoteDataSrc {
  const ProductRemoteDataSrcImpl(ApiService apiService)
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final data = await _apiService.get(url: ApiConst.productsUrl);

      debugPrint('Products Data : $data');

      final products = data['products'] as List<dynamic>;

      return products
          .map((product) => ProductModel.fromJson(product as SDMap))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> storeProduct(Product product) async {
    try {
      await _apiService.sendMultipartRequest(
        method: ApiConst.post,
        url: ApiConst.productsUrl,
        body: (product as ProductModel).toJson(),
        fieldName: 'images[]', // Use 'images[]' for multiple files
        files: product.images!.map(File.new).toList(),
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> updateProduct({
    required String id,
    required SDMap updates,
  }) async {
    try {
      debugPrint('updateProduct from product remote data source ....');

      if (updates.containsKey('images')) {
        debugPrint('Starting sendMultipartRequest ....');

        final images = updates.remove('images') as List<File?>;
        updates.addAll({'_method': ApiConst.patch});
        debugPrint('$updates');
        debugPrint('$images');
        await _apiService.sendMultipartRequest(
          method: ApiConst.post,
          url: '${ApiConst.productsUrl}/$id',
          body: updates,
          fieldName: 'images[]',
          files: images.whereType<File>().toList(),
        );
      } else {
        debugPrint('Starting patch request ....');

        await _apiService.patch(
          url: '${ApiConst.productsUrl}/$id',
          body: updates,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await _apiService.delete(url: '${ApiConst.productsUrl}/$id');
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
