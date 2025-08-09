import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const light = TextTheme(
    headlineMedium: TextStyle(
      color: Colours.grey800,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: Colours.black,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colours.black,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    bodySmall: TextStyle(color: Colours.grey900),
    titleSmall: TextStyle(color: Colours.grey900),
    labelSmall: TextStyle(color: Colours.grey500),
  );

  static const dark = TextTheme(
    headlineSmall: TextStyle(
      color: Colours.grey200,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(color: Colours.grey100),
    bodySmall: TextStyle(color: Colours.grey100),
    titleLarge: TextStyle(
      color: Colours.white,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colours.white,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(color: Colours.grey100),
    labelLarge: TextStyle(color: Colours.grey600),
    labelMedium: TextStyle(
      color: Colours.grey100,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(color: Colours.grey600),
  );
}
