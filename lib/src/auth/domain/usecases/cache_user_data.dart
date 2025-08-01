import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';
import 'package:ecommerce_admin_app/src/auth/domain/repos/auth_repo.dart';

class CacheUserData extends UseCaseWithParams<void, LocalUser> {
  CacheUserData(this._repo);

  final AuthRepo _repo;
  @override
  RFuture<void> call(LocalUser user) => _repo.cacheUserData(user);
}
