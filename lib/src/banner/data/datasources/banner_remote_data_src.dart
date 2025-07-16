import 'dart:io';

import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/services/api_service.dart';
import 'package:ecommerce_admin_app/src/banner/data/models/banner_model.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:flutter/material.dart';

abstract class BannerRemoteDataSrc {
  const BannerRemoteDataSrc();
  Future<List<BannerEntity>> getBanners();
  Future<void> storeBanner(BannerEntity banner);
  Future<void> updateBanner({required int id, required SDMap updates});
  Future<void> deleteBanner(int id);
}

class BannerRemoteDataSrcImpl implements BannerRemoteDataSrc {
  const BannerRemoteDataSrcImpl(ApiService apiService)
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<List<BannerEntity>> getBanners() async {
    try {
      final data = await _apiService.get(url: ApiConst.bannersUrl);

      debugPrint('Banners Data : $data');

      final banners = data['banners'] as List<dynamic>;

      return banners
          .map((banner) => BannerModel.fromJson(banner as SDMap))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> storeBanner(BannerEntity banner) async {
    try {
      await _apiService.sendMultipartRequest(
        method: ApiConst.post,
        url: ApiConst.categoriesUrl,
        body: (banner as BannerModel).toJson(),
        fieldName: 'icon',
        files: [File(banner.image)],
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<void> updateBanner({required int id, required SDMap updates}) async {
    debugPrint('updateBanner from remote data source ....');

    if (updates.containsKey('image')) {
      debugPrint('Starting sendMultipartRequest ....');

      final image = updates.remove('image') as File?;
      updates.addAll({'_method': ApiConst.patch});
      debugPrint('$updates');
      debugPrint('$image');
      await _apiService.sendMultipartRequest(
        method: ApiConst.post,
        url: '${ApiConst.bannersUrl}/$id',
        body: updates,
        fieldName: 'image',
        files: [image!],
      );
    } else {
      debugPrint('Starting patch request ....');

      await _apiService.patch(url: '${ApiConst.bannersUrl}/$id', body: updates);
    }
  }

  @override
  Future<void> deleteBanner(int id) async {
    try {
      await _apiService.delete(url: '${ApiConst.bannersUrl}/$id');
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UnknownException(message: e.toString());
    }
  }
}
