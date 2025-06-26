import 'package:ecommerce_admin_app/core/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';
import 'package:ecommerce_admin_app/src/auth/domain/repos/auth_repo.dart';

class GoogleLoginIn extends UseCaseWithoutParams<LocalUser>{

  GoogleLoginIn(this._repo);

  final AuthRepo _repo;
  
  @override
  RFuture<LocalUser> call() => _repo.googleSignIn();
  
}
