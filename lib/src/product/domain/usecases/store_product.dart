import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/repos/product_repo.dart';

class StoreProduct extends UseCaseWithParams<void, Product>{

  const StoreProduct(this._repo);

  final ProductRepo _repo;

  @override
  RFuture<void> call(Product product) => _repo.storeProduct(product);
  
}
