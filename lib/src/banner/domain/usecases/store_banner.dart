import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/repos/banner_repo.dart';

class StoreBanner extends UseCaseWithParams<void, BannerEntity> {
  const StoreBanner(this._repo);

  final BannerRepo _repo;

  @override
  RFuture<void> call(BannerEntity banner) => _repo.storeBanner(banner);
}
