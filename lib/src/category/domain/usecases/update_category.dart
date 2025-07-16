import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/repos/category_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateCategory extends UseCaseWithParams<void, UpdateCategoryParams> {
  const UpdateCategory(this._repo);

  final CategoryRepo _repo;

  @override
  RFuture<void> call(UpdateCategoryParams params) =>
      _repo.updateCategory(id: params.id, updates: params.updates);
}

class UpdateCategoryParams extends Equatable {
  const UpdateCategoryParams({required this.id, required this.updates});

  final int id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}
