part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class LoadingCategories extends CategoryState {
  const LoadingCategories();
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded(this.categories);

  final List<CategoryEntity> categories;

  @override
  List<Object> get props => [categories];
}

class StoringCategory extends CategoryState {
  const StoringCategory();
}

class CategoryStored extends CategoryState {
  const CategoryStored();
}

class UpdatingCategory extends CategoryState {
  const UpdatingCategory();
}

class CategoryUpdated extends CategoryState {
  const CategoryUpdated();
}

class DeletingCategory extends CategoryState {
  const DeletingCategory();
}

class CategoryDeleted extends CategoryState {
  const CategoryDeleted();
}

class CategoryError extends CategoryState {
  const CategoryError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
