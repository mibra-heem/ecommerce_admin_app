import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/usecases/get_banners.dart';
import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier {
  BannerProvider({
    required GetBanners getBanners,
  })  : _getBanners = getBanners;

  final GetBanners _getBanners;

  List<BannerEntity> _banners = [];

  List<BannerEntity> get banners => _banners;

  Future<void> getBannersHandler() async {
    final result = await _getBanners();

    result.fold(
      (failure) => failure.errorMessage,
      (banners) {
        debugPrint('Banners fetched successfully.');
        _banners = banners;
        debugPrint('$_banners');
        notifyListeners();
      }
    );
  }

  
}
