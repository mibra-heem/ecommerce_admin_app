import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';

abstract class ProductRepo {
  const ProductRepo();
  RFuture<List<Product>> getProducts();
  RFuture<void> storeProduct(Product product);
  RFuture<void> updateProduct({required String id, required SDMap updates});
  RFuture<void> deleteProduct(String id);
}
