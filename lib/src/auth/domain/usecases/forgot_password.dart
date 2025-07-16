import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class ForgotPassword extends UseCaseWithParams<void, ForgotPasswordParams> {
  ForgotPassword(this._repo);

  final AuthRepo _repo;
  @override
  RFuture<void> call(ForgotPasswordParams params) =>
      _repo.forgotPassword(params.email);
}

class ForgotPasswordParams extends Equatable {
  const ForgotPasswordParams({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
