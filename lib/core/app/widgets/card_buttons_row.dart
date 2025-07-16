import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CardActionButtons extends StatelessWidget {
  const CardActionButtons({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.isViewOn = true,
  });

  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isViewOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isViewOn)
          IconButton(
            icon: const Icon(IconlyBold.show, color: Colors.blueAccent),
            onPressed: onView,
          ),
        IconButton(
          icon: const Icon(IconlyBold.edit, color: Colors.amber),
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(IconlyBold.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
