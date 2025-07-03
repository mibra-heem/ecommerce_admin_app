import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/domain/usecases/store_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required StoreProduct storeProduct})
    : _storeProduct = storeProduct,
      super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      emit(const ProductLoading());
    });
    on<StoreProductEvent>(_storeProductHandler);
  }

  final StoreProduct _storeProduct;

  Future<void> _storeProductHandler(
    StoreProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    debugPrint('_storeProductHandler triggered .........');
    emit(const StoringProduct());

    await Future.delayed(const Duration(seconds: 5),(){});

    emit(const ProdutStored());

    // final result = await _storeProduct(event.product);

    // result.fold(
    //   (failure) => emit(ProductError(failure.errorMessage)),
    //   (_) {
    //     debugPrint('Product Created Successfully.');
    //     emit(const ProdutStored());
    //   },
    // );
  }
}
