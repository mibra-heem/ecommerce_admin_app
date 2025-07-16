import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/banner/domain/repos/banner_repo.dart';

class DeleteBanner extends UseCaseWithParams<void, int> {
  const DeleteBanner(this._repo);

  final BannerRepo _repo;

  @override
  RFuture<void> call(int id) => _repo.deleteBanner(id);
}
