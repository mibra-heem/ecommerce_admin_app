import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/errors/failure.dart';
import 'package:ecommerce_admin_app/src/product/data/datasources/product_remote_data_src.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/repos/product_repo.dart';
import 'package:flutter/material.dart';

class ProductRepoImpl implements ProductRepo {
  const ProductRepoImpl(this._remoteDataSrc);

  final ProductRemoteDataSrc _remoteDataSrc;

  @override
  RFuture<List<Product>> getProducts() async {
    try {
      final products = await _remoteDataSrc.getProducts();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<void> storeProduct(Product product) async {
    try {
      debugPrint('storeProduct from product Repo ....');
      await _remoteDataSrc.storeProduct(product);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<void> updateProduct({
    required String id,
    required SDMap updates,
  }) async {
    try {
      debugPrint('updateProduct from product Repo ....');
      await _remoteDataSrc.updateProduct(id: id, updates: updates);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  RFuture<void> deleteProduct(String id) async {
    try {
      await _remoteDataSrc.deleteProduct(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
