import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/repos/category_repo.dart';

class StoreCategory extends UseCaseWithParams<void, CategoryEntity> {
  const StoreCategory(this._repo);

  final CategoryRepo _repo;

  @override
  RFuture<void> call(CategoryEntity category) => _repo.storeCategory(category);
}
