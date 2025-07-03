import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<void,SignUpParams>{

  SignUp(this._repo);

  final AuthRepo _repo;
  
  @override
  RFuture<void> call(SignUpParams params) => _repo.signUp(
    email: params.email,
    fullName: params.name,
    password: params.password,
  );
}

class SignUpParams extends Equatable{

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  const SignUpParams.empty(): this(email: '', name: '',  password: '');

  final String email;
  final String name;
  final String password;

  @override
  List<Object?> get props => [email, name, password];

}
