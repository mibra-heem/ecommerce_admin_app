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
}
