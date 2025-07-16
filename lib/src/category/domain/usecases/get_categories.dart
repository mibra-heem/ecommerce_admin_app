import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/repos/category_repo.dart';

class GetCategories extends UseCaseWithoutParams<List<CategoryEntity>> {
  const GetCategories(this._repo);

  final CategoryRepo _repo;

  @override
  RFuture<List<CategoryEntity>> call() => _repo.getCategories();
}
