part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategoriesEvent extends CategoryEvent {
  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class StoreCategoryEvent extends CategoryEvent {
  const StoreCategoryEvent(this.category);

  final CategoryEntity category;

  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends CategoryEvent {
  const UpdateCategoryEvent({required this.id, required this.updates});
  final int id;
  final SDMap updates;

  @override
  List<Object?> get props => [id, updates];
}

class DeleteCategoryEvent extends CategoryEvent {
  const DeleteCategoryEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
