import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/get_products.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/store_product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/update_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required GetProducts getProducts,
    required StoreProduct storeProduct,
    required UpdateProduct updateProduct,
    required DeleteProduct deleteProduct,
  }) : _getProducts = getProducts,
       _storeProduct = storeProduct,
       _updateProduct = updateProduct,
       _deleteProduct = deleteProduct,
       super(ProductInitial()) {
    on<GetProductsEvent>(_getProductsHandler);
    on<StoreProductEvent>(_storeProductHandler);
    on<UpdateProductEvent>(_updateProductHandler);
    on<DeleteProductEvent>(_deleteProductHandler);
  }

  final GetProducts _getProducts;
  final StoreProduct _storeProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  Future<void> _getProductsHandler(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    debugPrint('_getProductsHandler triggered .........');
    emit(const StoringProduct());

    final result = await _getProducts();

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (
      products,
    ) {
      debugPrint('Products Loaded Successfully.');
      emit(ProductLoaded(products));
    });
  }

  Future<void> _storeProductHandler(
    StoreProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    debugPrint('_storeProductHandler triggered .........');
    emit(const StoringProduct());

    final result = await _storeProduct(event.product);

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (_) {
      debugPrint('Product Created Successfully.');
      emit(const ProdutStored());
    });
  }

  Future<void> _updateProductHandler(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    debugPrint('_updateProductHandler triggered .........');
    emit(const UpdatingProduct());

    final result = await _updateProduct(
      UpdateProductParams(id: event.id, updates: event.updates),
    );

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (_) {
      debugPrint('Product Updated Successfully.');
      emit(const ProductUpdated());
    });
  }

  Future<void> _deleteProductHandler(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    debugPrint('_deleteProductHandler triggered .........');
    emit(const UpdatingProduct());

    final result = await _deleteProduct(event.id);

    result.fold((failure) => emit(ProductError(failure.errorMessage)), (_) {
      debugPrint('Product Deleted Successfully.');
      emit(const ProductUpdated());
    });
  }
}
