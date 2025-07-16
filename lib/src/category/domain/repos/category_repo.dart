import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';

abstract class CategoryRepo {
  const CategoryRepo();
  RFuture<List<CategoryEntity>> getCategories();
  RFuture<void> storeCategory(CategoryEntity category);
  RFuture<void> updateCategory({
    required int id,
    required SDMap updates,
  });
  RFuture<void> deleteCategory(int id);
}
