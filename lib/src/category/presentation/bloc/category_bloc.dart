import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/usecases/store_category.dart';
import 'package:ecommerce_admin_app/src/category/domain/usecases/update_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    // required GetCategories getCategories,
    required StoreCategory storeCategory,
    required UpdateCategory updateCategory,
    // required DeleteCategory deleteCategory,
  }) : 
  // _getCategories = getCategories,
       _storeCategory = storeCategory,
       _updateCategory = updateCategory,
      //  _deleteCategory = deleteCategory,
       super(CategoryInitial()) {
    // on<GetCategoriesEvent>(_getCategoriesHandler);
    on<StoreCategoryEvent>(_storeCategoryHandler);
    on<UpdateCategoryEvent>(_updateCategoryHandler);
    // on<DeleteCategoryEvent>(_deleteCategoryHandler);
  }

  // final GetCategories _getCategories;
  final StoreCategory _storeCategory;
  final UpdateCategory _updateCategory;
  // final DeleteCategory _deleteCategory;

  // Future<void> _getCategoriesHandler(
  //   GetCategoriesEvent event,
  //   Emitter<CategoryState> emit,
  // ) async {
  //   debugPrint('_getCategoriesHandler triggered .........');
  //   emit(const StoringCategory());

  //   final result = await _getCategories();

  //   result.fold((failure) => emit(CategoryError(failure.errorMessage)), (
  //     categories,
  //   ) {
  //     debugPrint('Categories Loaded Successfully.');
  //     emit(CategoryLoaded(categories));
  //   });
  // }

  Future<void> _storeCategoryHandler(
    StoreCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    debugPrint('_storeCategoryHandler triggered .........');
    emit(const StoringCategory());

    final result = await _storeCategory(event.category);

    result.fold((failure) => emit(CategoryError(failure.errorMessage)), (_) {
      debugPrint('Category Created Successfully.');
      emit(const CategoryStored());
    });
  }

  Future<void> _updateCategoryHandler(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    debugPrint('_updateCategoryHandler triggered .........');
    emit(const UpdatingCategory());

    final result = await _updateCategory(
      UpdateCategoryParams(id: event.id, updates: event.updates),
    );

    result.fold((failure) => emit(CategoryError(failure.errorMessage)), (_) {
      debugPrint('Category Updated Successfully.');
      emit(const CategoryUpdated());
    });
  }

  // Future<void> _deleteCategoryHandler(
  //   DeleteCategoryEvent event,
  //   Emitter<CategoryState> emit,
  // ) async {
  //   debugPrint('_deleteCategoryHandler triggered .........');
  //   emit(const UpdatingCategory());

  //   final result = await _deleteCategory(event.id);

  //   result.fold((failure) => emit(CategoryError(failure.errorMessage)), (_) {
  //     debugPrint('Category Deleted Successfully.');
  //     emit(const CategoryUpdated());
  //   });
  // }
}
