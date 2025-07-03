import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/get_products.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({
    required GetProducts getProducts,
  })  : _getProducts = getProducts;

  final GetProducts _getProducts;

  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> getProductsHandler() async {
    final result = await _getProducts();

    result.fold(
      (failure) => debugPrint(failure.errorMessage),
      (products) {
        debugPrint('Products fetched successfully.');
        _products = products;
        debugPrint('$_products');
        notifyListeners();
      },
    );
  }
  
}
