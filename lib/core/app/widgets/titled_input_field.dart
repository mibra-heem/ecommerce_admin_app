import 'package:ecommerce_admin_app/core/app/widgets/field_label.dart';
import 'package:ecommerce_admin_app/core/app/widgets/my_field.dart';
import 'package:flutter/material.dart';

class TitledInputField extends StatelessWidget {
  const TitledInputField({
    required this.controller,
    required this.title,
    this.counterText,
    this.counterStyle,
    this.maxLength,
    this.maxLines,
    this.required = true,
    this.isTextArea = false,
    this.enableOnlyNumbers = false,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String title;
  final String? hintText;
  final String? counterText;
  final TextStyle? hintStyle;
  final TextStyle? counterStyle;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool required;
  final bool enableOnlyNumbers;
  final bool isTextArea;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(title: title, required: required),
        const SizedBox(height: 10),
        MyField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          maxLength: maxLength,
          maxLines: maxLines,
          enableOnlyNumbers: enableOnlyNumbers,
          counterText: counterText,
          counterStyle: counterStyle,
          overrideValidator: true,
          isTextArea: isTextArea,
          validator: (value) {
            if (!required) return null;
            if (value == null || value == '') {
              return 'This field is required.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
