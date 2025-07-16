import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.name,
    super.id,
    super.parentId,
    super.slug,
    super.icon,
    super.description,
    super.isActive,
    super.order,
  });

  const CategoryModel.empty() : super.empty();

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'] as int?,
      name: data['name'] as String,
      parentId: data['parent_id'] as int?,
      slug: data['slug'] as String?,
      icon: data['icon_url'] as String?,
      description: data['description'] as String?,
      isActive: CoreUtils.toBoolean((data['is_active'] ?? 1) as int),
      order: (data['order'] ?? 0) as int,
    );
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    int? parentId,
    String? slug,
    String? icon,
    String? description,
    bool? isActive,
    int? order,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (parentId != null) 'parent_id': parentId,
      'slug': slug,
      'icon': icon,
      'description': description,
      'is_active': isActive,
      'order': order,
    };
  }
}
