import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/errors/failure.dart';
import 'package:ecommerce_admin_app/src/banner/data/datasources/banner_remote_data_src.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/repos/banner_repo.dart';

class BannerRepoImpl implements BannerRepo {
  const BannerRepoImpl(this._remoteDataSrc);

  final BannerRemoteDataSrc _remoteDataSrc;

  @override
  RFuture<List<BannerEntity>> getBanners() async {
    try {
      final banners = await _remoteDataSrc.getBanners();
      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  
  @override
  RFuture<void> deleteBanner(int id) {
    // TODO: implement deleteBanner
    throw UnimplementedError();
  }
  
  @override
  RFuture<void> storeBanner(BannerEntity banner) {
    // TODO: implement storeBanner
    throw UnimplementedError();
  }
  
  @override
  RFuture<void> updateBanner({required int id, required SDMap updates}) {
    // TODO: implement updateBanner
    throw UnimplementedError();
  }
}
