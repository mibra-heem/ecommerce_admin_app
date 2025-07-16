import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
    this.label, {
    required this.onPressed,
    this.padding,
    this.fontSize,
    this.labelStyle,
    this.elevation,
    this.labelColor,
    this.buttonColor,
    super.key,
  });

  final String label;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final Color? labelColor;
  final double? fontSize;
  final Color? buttonColor;
  final double? elevation;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: buttonColor ?? context.color.onSecondary,
        foregroundColor: labelColor ?? Colours.grey100,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize ?? 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
