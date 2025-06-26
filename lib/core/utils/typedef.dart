import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/failure.dart';

typedef RFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
typedef SSMap = Map<String, String>;
