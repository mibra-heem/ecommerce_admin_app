import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/usecases/delete_banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/usecases/get_banners.dart';
import 'package:ecommerce_admin_app/src/banner/domain/usecases/store_banner.dart';
import 'package:ecommerce_admin_app/src/banner/domain/usecases/update_banner.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({
    required GetBanners getBanners,
    required StoreBanner storeBanner,
    required UpdateBanner updateBanner,
    required DeleteBanner deleteBanner,
  }) : _getBanners = getBanners,
       _storeBanner = storeBanner,
       _updateBanner = updateBanner,
       _deleteBanner = deleteBanner,
       super(BannerInitial()) {
    on<GetBannersEvent>(_getBannersHandler);
    on<StoreBannerEvent>(_storeBannerHandler);
    on<UpdateBannerEvent>(_updateBannerHandler);
    on<DeleteBannerEvent>(_deleteBannerHandler);
  }

  final GetBanners _getBanners;
  final StoreBanner _storeBanner;
  final UpdateBanner _updateBanner;
  final DeleteBanner _deleteBanner;

  Future<void> _getBannersHandler(
    GetBannersEvent event,
    Emitter<BannerState> emit,
  ) async {
    debugPrint('_getBannersHandler triggered .........');
    emit(const StoringBanner());

    final result = await _getBanners();

    result.fold((failure) => emit(BannerError(failure.errorMessage)), (
      Banners,
    ) {
      debugPrint('Banners Loaded Successfully.');
      emit(BannerLoaded(Banners));
    });
  }

  Future<void> _storeBannerHandler(
    StoreBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    debugPrint('_storeBannerHandler triggered .........');
    emit(const StoringBanner());

    final result = await _storeBanner(event.banner);

    result.fold((failure) => emit(BannerError(failure.errorMessage)), (_) {
      debugPrint('Banner Created Successfully.');
      emit(const BannerStored());
    });
  }

  Future<void> _updateBannerHandler(
    UpdateBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    debugPrint('_updateBannerHandler triggered .........');
    emit(const UpdatingBanner());

    final result = await _updateBanner(
      UpdateBannerParams(id: event.id, updates: event.updates),
    );

    result.fold((failure) => emit(BannerError(failure.errorMessage)), (_) {
      debugPrint('Banner Updated Successfully.');
      emit(const BannerUpdated());
    });
  }

  Future<void> _deleteBannerHandler(
    DeleteBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    debugPrint('_deleteBannerHandler triggered .........');
    emit(const UpdatingBanner());

    final result = await _deleteBanner(event.id);

    result.fold((failure) => emit(BannerError(failure.errorMessage)), (_) {
      debugPrint('Banner Deleted Successfully.');
      emit(const BannerUpdated());
    });
  }
}
