part of 'banner_bloc.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

class LoadingBanners extends BannerState {
  const LoadingBanners();
}

class BannerLoaded extends BannerState {
  const BannerLoaded(this.banners);

  final List<BannerEntity> banners;

  @override
  List<Object> get props => [banners];
}

class StoringBanner extends BannerState {
  const StoringBanner();
}

class BannerStored extends BannerState {
  const BannerStored();
}

class UpdatingBanner extends BannerState {
  const UpdatingBanner();
}

class BannerUpdated extends BannerState {
  const BannerUpdated();
}

class DeletingBanner extends BannerState {
  const DeletingBanner();
}

class BannerDeleted extends BannerState {
  const BannerDeleted();
}

class BannerError extends BannerState {
  const BannerError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
