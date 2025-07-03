import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CardButtonsRow extends StatelessWidget {
  const CardButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: RoundedButton(
            'View', 
            labelColor: Colors.blueAccent,
            onPressed: (){},
          ),
        ),
        Expanded(
          child: RoundedButton(
            'Edit', 
            labelColor: context.color.primary,
            onPressed: (){},
          ),
        ),
        Expanded(
          child: RoundedButton(
            'Delete', 
            labelColor: Colours.danger,
            onPressed: (){},
          ),
        ),
      ],
    );
  }
}
