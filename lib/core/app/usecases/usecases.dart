import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';

abstract class UseCaseWithoutParams<Type>{

  const UseCaseWithoutParams();

  RFuture<Type> call();

}

abstract class UseCaseWithParams<Type, Params>{

  const UseCaseWithParams();

  RFuture<Type> call(Params params);

}
