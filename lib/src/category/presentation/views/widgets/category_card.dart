import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/card_buttons_row.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.category,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final CategoryEntity category;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colours.grey900 : Colours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(22),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon or image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                category.icon != null
                    ? CachedNetworkImage(
                      imageUrl: category.icon!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => _defaultIcon(),
                      placeholder:
                          (_, _) => const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                    )
                    : _defaultIcon(),
          ),
          const SizedBox(width: 14),

          // Category Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        context.isDarkMode ? Colours.grey100 : Colours.grey900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.description ?? 'No description available.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        context.isDarkMode ? Colours.grey500 : Colours.grey700,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Chip(
                      label: Text(category.slug ?? 'no-slug'),
                      labelStyle: const TextStyle(fontSize: 11),
                      backgroundColor: Colours.primaryLight.withAlpha(25),
                    ),
                    Text(
                      category.isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            category.isActive
                                ? Colours.success
                                : Colours.disable,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Order: ${category.order}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colours.grey600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Edit/Delete buttons
          CardActionButtons(
            isViewOn: false,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _defaultIcon() {
    return Container(
      height: 50,
      width: 50,
      color: Colours.grey200,
      child: const Icon(IconlyLight.category, size: 28, color: Colours.primary),
    );
  }
}
