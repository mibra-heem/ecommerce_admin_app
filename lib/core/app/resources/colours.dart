import 'package:flutter/material.dart';

class Colours {
  Colours._();

  static const gradient = [
    Color(0xFFEDF8FF),
    Color(0xFFFDC1E8),
    Color(0xFFFFFFFF),
    Color(0xFFFDFAE1),
  ];

  // Main colors
  static const primary = Color(0xFF14823C);
  static const primaryLight = Color(0xFF34A33C);
  static const primaryDark = Color(0xFF0F5F3C);

  // Accent colors
  static const secondary = Color(0xFFFFC107);
  static const secondaryDark = Color(0xFFFFA000);
  static const secondaryLight = Color(0xFFFFD54F);

  // Neutral colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Color(0xFF9E9E9E);

  // Shades 
  static const grey100 = Color(0xFFF5F5F5);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey500 = Color(0xFF9E9E9E);
  static const grey600 = Color(0xFF757575);
  static const grey700 = Color(0xFF616161);
  static const grey800 = Color(0xFF424242);
  static const grey900 = Color(0xFF212121);

  static const textFieldLight = Color(0xFFDADADA);
  static const textFieldDark = Color(0xFF1E1E1E);

  static const scaffoldLight = Color(0xFFEFEFEE);
  static const scaffoldDark = Color(0xFF121212);

  static const appBarLight = primary;
  static const appBarDark = Color(0xFF1C1C1C);

  static const navBarLight = Color(0xFFF7F7F7);
  static const navBarDark = Color(0xFF181818);

  static const tileLight = white;
  static const tileDark = Color(0xFF1E1E1E);

  // Utility Colors
  static const success = Colors.green;
  static const danger = Colors.red;
  static const disable = Colors.grey;

  static const colorSchemeLight = ColorScheme.light(
    primary: primary,
    onPrimary: grey100,
    primaryContainer: primaryLight,
    secondary: grey900,
    onSecondary: grey100,
  );

  static const colorSchemeDark = ColorScheme.dark(
    primary: primary,
    onPrimary: grey100,
    primaryContainer: primaryLight,
    secondary: grey100,
    onSecondary: grey900,
  );

}
