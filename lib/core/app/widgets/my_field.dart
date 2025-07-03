import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyField extends StatelessWidget {
  const MyField({
    required this.controller,
    this.matchField = '',
    this.validator,
    this.filled = true,
    this.fillColor,
    this.obscureText = false,
    this.validatePassword = false,
    this.keyboardType,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.hintStyle,
    this.counterStyle,
    this.overrideValidator = false,
    this.isTextArea = false,
    this.maxLines,
    this.counterText,
    this.maxLength,
    this.isFocusOnTapOutside = true,
    this.enableColor,
    this.focusColor,
    this.borderColor,
    this.inputFormatters,
    this.enabled = true,
    this.enableOnlyNumbers = false,
    super.key,
  });

  final TextEditingController controller;
  final String matchField;
  final String? Function(String?)? validator;
  final bool filled;
  final Color? fillColor;
  final bool obscureText;
  final bool validatePassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final bool overrideValidator;
  final int? maxLines;
  final bool isTextArea;
  final String? counterText;
  final int? maxLength;
  final bool isFocusOnTapOutside;
  final Color? borderColor;
  final Color? enableColor;
  final Color? focusColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool enableOnlyNumbers;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator ? validator : (value){
        if(value == null || value == ''){
          return 'This field is required.';
        }
        return validator?.call(value);
      },
      onTapOutside: isFocusOnTapOutside 
        ? (_) => FocusScope.of(context).unfocus() 
        : null,
      style: context.theme.textTheme.bodyLarge,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: enableOnlyNumbers ? TextInputType.number : keyboardType,
      inputFormatters: enableOnlyNumbers ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ] : inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        counterText: counterText,
        counterStyle: counterStyle ?? const TextStyle(color: Colours.primary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 12,
        ),
      ),
    );
  }
}
