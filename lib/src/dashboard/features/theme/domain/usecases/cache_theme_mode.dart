import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/dashboard/features/theme/domain/repo/theme_repo.dart';

class CacheThemeMode extends UseCaseWithParams<void, int>{

  const CacheThemeMode(this._repo);

  final ThemeRepo _repo;

  @override
  RFuture<void> call(int index) => _repo.cacheThemeMode(index);
}
