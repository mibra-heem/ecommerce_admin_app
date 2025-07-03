import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/data/models/category_model.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.name,
    required super.category,
    required super.price,
    super.id,
    super.image,
    super.description,
    super.isActive,
  });

  const ProductModel.empty() : super.empty();

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] as String?,
      name: data['name'] as String,
      category:
          CategoryModel.fromJson(data['category'] as SDMap),
      price: data['price'] as int,
      image: data['image'] as String?,
      description: data['description'] as String?,
      // isActive: data['is_active'] as bool,
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? categoryId,
    CategoryEntity? category,
    int? price,
    String? image,
    String? description,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'is_active': isActive,
    };
  }
}
