import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/themes/extensions/product_card_theme_extension.dart';
import 'package:flutter/cupertino.dart';

class AppProductCardTheme {
  const AppProductCardTheme._();

  static const light = ProductCardTheme(
    titleStyle: TextStyle(fontSize: 14),
    gradientBackground: LinearGradient(
      colors: Colours.productCardGradientLight,
    ),
    priceStyle: TextStyle(),
    backgroundColor: Colours.grey900,
    borderRadius: 12,
    boxShadow: BoxShadow(),
  );

  static const dark = ProductCardTheme(
    titleStyle: TextStyle(fontSize: 14),
    gradientBackground: LinearGradient(colors: Colours.productCardGradientDark),
    priceStyle: TextStyle(),
    backgroundColor: Colours.grey100,
    borderRadius: 12,
    boxShadow: BoxShadow(),
  );
}
