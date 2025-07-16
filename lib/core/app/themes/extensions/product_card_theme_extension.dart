import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class ProductCardTheme extends ThemeExtension<ProductCardTheme> {
  const ProductCardTheme({
    required this.backgroundColor,
    required this.titleStyle,
    required this.priceStyle,
    required this.borderRadius,
    required this.boxShadow,
    required this.gradientBackground,
  });
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle priceStyle;
  final double borderRadius;
  final BoxShadow boxShadow;
  final Gradient gradientBackground;

  @override
  ProductCardTheme copyWith({
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? priceStyle,
    double? borderRadius,
    BoxShadow? boxShadow,
    Gradient? gradientBackground,
  }) {
    return ProductCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      priceStyle: priceStyle ?? this.priceStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      gradientBackground: gradientBackground ?? this.gradientBackground,
    );
  }

  @override
  ProductCardTheme lerp(ThemeExtension<ProductCardTheme>? other, double t) {
    if (other is! ProductCardTheme) return this;

    return ProductCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      priceStyle: TextStyle.lerp(priceStyle, other.priceStyle, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      boxShadow: BoxShadow.lerp(boxShadow, other.boxShadow, t)!,
      gradientBackground:
          Gradient.lerp(gradientBackground, other.gradientBackground, t)!,
    );
  }
}
