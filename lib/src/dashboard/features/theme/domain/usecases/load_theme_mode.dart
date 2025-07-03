import 'package:ecommerce_admin_app/core/app/usecases/usecases.dart';
import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/dashboard/features/theme/domain/repo/theme_repo.dart';

class LoadThemeMode extends UseCaseWithoutParams<int>{

  const LoadThemeMode(this._repo);

  final ThemeRepo _repo;

  @override
  RFuture<int> call() => _repo.loadThemeMode();
}
