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
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct();
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
      await _apiService.postMultiPart(
        url: ApiConst.productsUrl,
        body: (product as ProductModel).toJson(),
        fieldName: 'image',
        file: File(product.image!),
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct() {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
