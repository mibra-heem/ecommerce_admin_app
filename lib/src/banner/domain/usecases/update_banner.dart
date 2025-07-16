import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/banner/domain/repos/banner_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateBanner extends UseCaseWithParams<void, UpdateBannerParams> {
  const UpdateBanner(this._repo);

  final BannerRepo _repo;

  @override
  RFuture<void> call(UpdateBannerParams params) =>
      _repo.updateBanner(id: params.id, updates: params.updates);
}

class UpdateBannerParams extends Equatable {
  const UpdateBannerParams({required this.id, required this.updates});

  final int id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}
