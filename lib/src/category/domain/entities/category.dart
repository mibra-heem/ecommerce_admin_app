import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.name,
    this.id,
    this.parentId,
    this.slug,
    this.icon,
    this.description,
    this.isActive = true,
    this.order = 0,
  });

  const CategoryEntity.empty() : this(name: 'CategoryEntity.name');

  final int? id;
  final String name;
  final int? parentId;
  final String? slug;
  final String? icon;
  final String? description;
  final bool isActive;
  final int order;

  @override
  List<Object?> get props => [
    id,
    name,
    parentId,
    slug,
    icon,
    description,
    isActive,
    order,
  ];

  @override
  String toString() {
    return 'Category{ id: $id, name: $name, slug: $slug, icon: $icon, '
        'parentId: $parentId, description: $description, isActive: $isActive, '
        'order: $order }';
  }
}
