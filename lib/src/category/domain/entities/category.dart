import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable{

  const CategoryEntity({
    required this.id,
    required this.name,
    this.image,
  });

  const CategoryEntity.empty() : this(
    id: 0,
    name: 'CategoryEntity.name',
  );

  final int id;
  final String name;
  final String? image;

  @override
  List<Object?> get props => [
    id, name, image,
  ];

  @override
  String toString(){
    return 'Category{id: $id, name: $name, image : $image}';
  }


}
