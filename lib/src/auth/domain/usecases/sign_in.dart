import 'package:equatable/equatable.dart';
import 'package:ecommerce_admin_app/core/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';
import 'package:ecommerce_admin_app/src/auth/domain/repos/auth_repo.dart';

class SignIn extends UseCaseWithParams<LocalUser,SignInParams>{

  SignIn(this._repo);

  final AuthRepo _repo;
  
  @override
  RFuture<LocalUser> call(SignInParams params) => _repo.signIn(
    email: params.email,
    password: params.password,
  );
  
}

class SignInParams extends Equatable{

  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty(): this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

}
