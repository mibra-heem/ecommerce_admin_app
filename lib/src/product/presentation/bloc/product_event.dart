part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();

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
  const UpdateProductEvent({required this.id, required this.updates});
  final String id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}

class DeleteProductEvent extends ProductEvent {
  const DeleteProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
