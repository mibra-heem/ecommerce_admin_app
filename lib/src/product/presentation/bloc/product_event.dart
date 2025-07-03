part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class StoreProductEvent extends ProductEvent {
  const StoreProductEvent(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  const UpdateProductEvent(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  const DeleteProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}