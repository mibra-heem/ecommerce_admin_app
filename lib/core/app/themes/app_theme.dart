import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/resources/fonts.dart';
import 'package:ecommerce_admin_app/core/app/themes/app_color_scheme.dart';
import 'package:ecommerce_admin_app/core/app/themes/app_input_decoration_theme.dart';
import 'package:ecommerce_admin_app/core/app/themes/app_text_theme.dart';
import 'package:ecommerce_admin_app/core/app/themes/my_app_bar_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: Fonts.poppins,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: Colours.primary,
    colorScheme: AppColorScheme.light,
    applyElevationOverlayColor: false,
    shadowColor: Colors.transparent,
    splashColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: Colours.scaffoldLight,
    textTheme: AppTextTheme.light,
    appBarTheme: MyAppBarTheme.light,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        surfaceTintColor: Colours.white,
        foregroundColor: Colours.grey900,
      ),
    ),
    dividerTheme: const DividerThemeData(color: Colours.grey600),
    dialogTheme: const DialogThemeData(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colours.scaffoldLight,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Colours.primary,
      textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: Fonts.poppins,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colours.navBarLight,
      selectedIconTheme: IconThemeData(color: Colours.primaryLight),
      selectedItemColor: Colours.primaryLight,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colours.primary,
      foregroundColor: Colours.white,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colours.white,
      surfaceTintColor: Colours.white,
    ),
    inputDecorationTheme: AppInputDecorationTheme.light,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: Fonts.poppins,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    shadowColor: Colors.transparent,
    splashColor: Colors.transparent,
    primaryColor: Colours.primary,
    colorScheme: AppColorScheme.dark,
    applyElevationOverlayColor: false,
    scaffoldBackgroundColor: Colours.scaffoldDark,
    splashFactory: NoSplash.splashFactory,
    textTheme: AppTextTheme.dark,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        surfaceTintColor: Colours.grey900,
        foregroundColor: Colours.grey100,
      ),
    ),
    dividerTheme: const DividerThemeData(color: Colours.grey300),
    dialogTheme: const DialogThemeData(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colours.grey900,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Colours.white,
      textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontFamily: Fonts.poppins,
      ),
    ),
    appBarTheme: MyAppBarTheme.dark,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colours.primaryLight,
      foregroundColor: Colours.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colours.navBarDark,
      selectedIconTheme: IconThemeData(color: Colours.primaryLight),
      selectedItemColor: Colours.primaryLight,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colours.grey100,
    ),
    inputDecorationTheme: AppInputDecorationTheme.dark,
  );
}
