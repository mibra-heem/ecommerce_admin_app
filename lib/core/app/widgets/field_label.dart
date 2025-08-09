import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    required this.title,
    this.suffixIcon,
    this.required = true,
    super.key,
  });

  final String title;
  final bool required;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: context.theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            children:
                !required
                    ? null
                    : const [
                      TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                    ],
          ),
        ),
        if (suffixIcon != null) suffixIcon!,
      ],
    );
  }
}
