import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/repos/category_repo.dart';

class DeleteCategory extends UseCaseWithParams<void, int> {
  const DeleteCategory(this._repo);

  final CategoryRepo _repo;

  @override
  RFuture<void> call(int id) => _repo.deleteCategory(id);
}
