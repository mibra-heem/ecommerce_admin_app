import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/enums/update_user_action.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';

abstract class AuthRepo{

  const AuthRepo();

  RFuture<void> forgotPassword(String email);
  RFuture<LocalUser> googleSignIn();
  RFuture<LocalUser> signIn({
    required String email,
    required String password,
  });
  RFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });
  RFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
  RFuture<void> cacheUserData(LocalUser user);
  RFuture<LocalUser> getUserCachedData();

}
