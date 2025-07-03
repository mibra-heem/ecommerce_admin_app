import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormButtonsRow extends StatelessWidget {
  const FormButtonsRow({
    required this.mainButtonLabel,
    this.onPressed,
    super.key,
  });

  final String mainButtonLabel;
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
        Expanded(
          child: RoundedButton(
            mainButtonLabel,
            fontSize: 14,
            padding: const EdgeInsets.symmetric(vertical: 16),
            buttonColor: Colours.primaryLight,
            labelColor: Colours.grey100,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
