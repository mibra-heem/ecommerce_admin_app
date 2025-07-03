import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/errors/failure.dart';
import 'package:ecommerce_admin_app/src/category/data/datasources/category_remote_data_src.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/repos/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  const CategoryRepoImpl(this._remoteDataSrc);

  final CategoryRemoteDataSrc _remoteDataSrc;

  @override
  RFuture<List<CategoryEntity>> getCategories() async{
    try {
      final categories = await _remoteDataSrc.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
