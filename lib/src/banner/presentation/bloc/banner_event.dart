part of 'banner_bloc.dart';

sealed class BannerEvent extends Equatable {
  const BannerEvent();
}

class GetBannersEvent extends BannerEvent {
  const GetBannersEvent();

  @override
  List<Object> get props => [];
}

class StoreBannerEvent extends BannerEvent {
  const StoreBannerEvent(this.banner);

  final BannerEntity banner;

  @override
  List<Object> get props => [banner];
}

class UpdateBannerEvent extends BannerEvent {
  const UpdateBannerEvent({required this.id, required this.updates});
  final int id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}

class DeleteBannerEvent extends BannerEvent {
  const DeleteBannerEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
