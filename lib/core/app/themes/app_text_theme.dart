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
    titleMedium: TextStyle(
      color: Colours.grey600,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Colours.grey700,
      overflow: TextOverflow.ellipsis,
    ),
  );

  static const dark = TextTheme(
    headlineSmall: TextStyle(
      color: Colours.grey200,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(color: Colours.grey100),
    labelLarge: TextStyle(color: Colours.grey600),
    titleSmall: TextStyle(color: Colours.grey100, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(
      color: Colours.grey600,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Colours.grey500,
      overflow: TextOverflow.ellipsis,
    ),
    labelMedium: TextStyle(
      color: Colours.grey100,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
