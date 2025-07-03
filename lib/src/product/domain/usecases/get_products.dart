import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/repos/product_repo.dart';

class GetProducts extends UseCaseWithoutParams<List<Product>>{

  const GetProducts(this._repo);

  final ProductRepo _repo;

  @override
  RFuture<List<Product>> call() => _repo.getProducts();
  
}
