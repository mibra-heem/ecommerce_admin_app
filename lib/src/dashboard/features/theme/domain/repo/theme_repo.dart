import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';

abstract class ThemeRepo {
  const ThemeRepo();

  RFuture<int> loadThemeMode(); 
  RFuture<void> cacheThemeMode(int index); 

}
