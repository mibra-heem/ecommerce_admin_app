import 'dart:io';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/store_product.dart';
import 'package:flutter/material.dart';

class ProductCreateProvider extends ChangeNotifier {
  ProductCreateProvider({
    required StoreProduct storeProduct,
  })  : _storeProduct = storeProduct;

  final StoreProduct _storeProduct;

  bool _isCreating = false;
  bool get isCreating => _isCreating;

  bool _isCreated = false;
  bool get isCreated => _isCreated;

  int? _selectedCategoryId;
  int? get selectedCategoryId => _selectedCategoryId;
  set selectedCategoryId(int? id){
    _selectedCategoryId = id;
    notifyListeners();
  }

  final List<File?> _images = [];
  List<File?> get images => _images;

  void addImage(File image){
    _images.add(image);
    notifyListeners();
  }

  Future<void> storeProductHandler(Product product) async {
    _isCreating = true;
    notifyListeners();
    final result = await _storeProduct(product);

    result.fold(
      (failure) {
        debugPrint(failure.errorMessage);
        _isCreated = false;
      },
      (_) {
        debugPrint('Product Created Successfully.');
        _isCreating = false;
        _isCreated = true;
      },
    );
    notifyListeners();

  }
  
}
