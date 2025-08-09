import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:flutter/material.dart';

class AppInputDecorationTheme {
  const AppInputDecorationTheme._();

  static const light = InputDecorationTheme(
    filled: true,
    fillColor: Colours.textFieldLight,
    counterStyle: TextStyle(
      color: Colours.primaryLight,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(color: Colours.grey600),
    focusedBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colours.textFieldLight),
    ),
    border: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colours.textFieldLight),
    ),
    enabledBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colours.textFieldLight),
    ),
    suffixIconColor: Colours.black,
    prefixIconColor: Colours.black,
  );

  static const dark = InputDecorationTheme(
    filled: true,
    fillColor: Colours.textFieldDark,
    counterStyle: TextStyle(
      color: Colours.primaryLight,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(color: Colours.grey400),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
    border: OutlineInputBorder(borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    suffixIconColor: Colours.white,
    prefixIconColor: Colours.white,
  );
}
