import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/data/models/category_model.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.name,
    required super.price,
    required super.category,
    super.id,
    super.images,
    super.description,
    super.isActive,
  });

  const ProductModel.empty() : super.empty();

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] as String?,
      name: data['name'] as String,
      category: CategoryModel.fromJson(data['category'] as SDMap),
      price: data['price'] as int,
      images:
          data['image_urls'] != null
              ? List<String>.from(data['image_urls'] as List<dynamic>)
              : null,
      description: data['description'] as String?,
      isActive: CoreUtils.toBoolean(data['is_active'] as int),
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? categoryId,
    CategoryEntity? category,
    int? price,
    List<String>? images,
    String? description,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      images: images ?? this.images,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_urls': images,
      'category_id': category.id,
      'price': price,
      'description': description,
      'is_active': isActive,
    };
  }
}
