import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';

abstract class BannerRepo {
  const BannerRepo();
  RFuture<List<BannerEntity>> getBanners();
    RFuture<void> storeBanner(BannerEntity banner);
  RFuture<void> updateBanner({
    required int id,
    required SDMap updates,
  });
  RFuture<void> deleteBanner(int id);
}
