import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/repos/product_repo.dart';

class DeleteProduct extends UseCaseWithParams<void, String> {
  const DeleteProduct(this._repo);

  final ProductRepo _repo;

  @override
  RFuture<void> call(String id) => _repo.deleteProduct(id);
}
