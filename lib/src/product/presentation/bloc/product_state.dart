part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class LoadingProducts extends ProductState {
  const LoadingProducts();
}

class ProductLoaded extends ProductState {
  const ProductLoaded(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

class StoringProduct extends ProductState {
  const StoringProduct();
}

class ProdutStored extends ProductState {
  const ProdutStored();
}

class UpdatingProduct extends ProductState {
  const UpdatingProduct();
}

class ProductUpdated extends ProductState {
  const ProductUpdated();
}

class DeletingProduct extends ProductState {
  const DeletingProduct();
}

class ProductDeleted extends ProductState {
  const ProductDeleted();
}

class ProductError extends ProductState {
  const ProductError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
