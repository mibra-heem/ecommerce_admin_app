import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormButtonsRow extends StatelessWidget {
  const FormButtonsRow({
    required this.actionButton,
    this.buttonColor,
    this.onPressed,
    super.key,
  });

  final Widget actionButton;
  final Color? buttonColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoundedButton(
            'Cancel',
            buttonColor: context.color.secondary,
            labelColor: context.color.onSecondary,
            fontSize: 14,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: actionButton),
      ],
    );
  }
}
