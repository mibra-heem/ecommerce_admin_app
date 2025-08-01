import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
    : assert(
        statusCode is String || statusCode is int,
        'Status Code is ${statusCode.runtimeType}',
      );

  final String message;
  final Object statusCode;

  String get errorMessage {
    final showErrorText =
        statusCode is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode${showErrorText ? ' Error' : ''}:  $message';
  }

  @override
  List<Object> get props => [message, statusCode];
}

class InternetFailure extends Failure {
  InternetFailure({required super.message, required super.statusCode});
}

class DataFailure extends Failure {
  DataFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}
