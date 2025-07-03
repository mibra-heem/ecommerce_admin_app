import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable{

  const Product({
    required this.name,
    required this.category,
    required this.price,
    this.id,
    this.image,
    this.description,
    this.isActive = true,
  });

  const Product.empty() : this(
    name: 'product.name',
    category: const CategoryEntity.empty(),
    price: 0,
  );

  final String? id;
  final String name;
  final int price;
  final CategoryEntity category;
  final String? image;
  final String? description;
  final bool isActive;

  @override
  List<Object?> get props => [
    id, name, category, price, image, description, isActive,
  ];

  @override
  String toString(){
    return 'Product{id: $id, name: $name, price : $price, image: $image, ' 
    'category : $category, description : $description}';
  }

}
