import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/domain/usecases/get_categories.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider({required GetCategories getCategories})
    : _getCategories = getCategories {
    debugPrint('CategoryProvider created');
    Future.microtask(getCategoriesHandler);
  }

  final GetCategories _getCategories;

  List<CategoryEntity> _categories = [];

  List<CategoryEntity> get categories => _categories;

  Future<void> getCategoriesHandler() async {
    debugPrint('getCategoriesHandler ...............');
    final result = await _getCategories();

    result.fold((failure) => failure.errorMessage, (categories) {
      debugPrint('Categories fetched successfully.');
      _categories = categories;
      debugPrint('$_categories');
      notifyListeners();
    });
  }
}
