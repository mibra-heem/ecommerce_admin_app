import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/usecases/delete_category.dart';
import 'package:ecommerce_admin_app/src/category/domain/usecases/get_categories.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider({
    required GetCategories getCategories,
    required DeleteCategory deleteCategory,
  }) : _getCategories = getCategories,
       _deleteCategory = deleteCategory {
    debugPrint('CategoryProvider created');
    Future.microtask(getCategoriesHandler);
  }

  final GetCategories _getCategories;
  final DeleteCategory _deleteCategory;

  List<CategoryEntity> _categories = [];
  List<CategoryEntity> get categories => _categories;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getCategoriesHandler() async {
    debugPrint('getCategoriesHandler ...............');
    isLoading = true;
    final result = await _getCategories();

    result.fold((failure) => failure.errorMessage, (categories) {
      debugPrint('Categories fetched successfully.');
      _categories = categories;
      debugPrint('$_categories');
      isLoading = false;
    });
  }

  Future<void> deleteCategoryHandler(int id) async {
    debugPrint('deleteCategoryHandler triggered .........');

    final result = await _deleteCategory(id);

    result.fold((failure) => debugPrint(failure.errorMessage), (_) {
      debugPrint('Category Deleted Successfully.');
    });
  }
}
