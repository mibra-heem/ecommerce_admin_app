import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/repos/product_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateProduct extends UseCaseWithParams<void, UpdateProductParams> {
  const UpdateProduct(this._repo);

  final ProductRepo _repo;

  @override
  RFuture<void> call(UpdateProductParams params) =>
      _repo.updateProduct(id: params.id, updates: params.updates);
}

class UpdateProductParams extends Equatable {
  const UpdateProductParams({required this.id, required this.updates});

  final String id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}
