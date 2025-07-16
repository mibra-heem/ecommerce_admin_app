import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.name,
    required this.price,
    required this.category,
    this.id,
    this.slug,
    this.images,
    this.description,
    this.isActive = true,
  });

  const Product.empty()
    : this(
        name: 'product.name',
        price: 0,
        category: const CategoryEntity.empty(),
      );

  final String? id;
  final String name;
  final String? slug;
  final int price;
  final CategoryEntity category;
  final List<String>? images;
  final String? description;
  final bool isActive;

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    category,
    price,
    images,
    description,
    isActive,
  ];

  @override
  String toString() {
    return 'Product{ id: $id, name: $name, slug: $slug price : $price, '
        'images: $images, category : $category, '
        'description : $description }';
  }
}
