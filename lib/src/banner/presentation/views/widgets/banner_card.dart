import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    required this.banner,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final BannerEntity banner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colours.grey900 : Colours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: banner.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              placeholder:
                  (_, _) => Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
              errorWidget:
                  (_, _, _) => Container(
                    height: 80,
                    width: 80,
                    color: Colours.grey300,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colours.grey600,
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${banner.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colours.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        banner.isActive
                            ? Colours.success.withAlpha(3)
                            : Colours.disable.withAlpha(3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    banner.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          banner.isActive ? Colours.success : Colours.disable,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Actions
          if (onEdit != null || onDelete != null) ...[
            const SizedBox(width: 8),
            if (onEdit != null)
              IconButton(
                onPressed: onEdit,
                icon: const Icon(IconlyBold.edit, size: 20),
                color: Colours.primary,
                tooltip: 'Edit',
              ),
            if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: const Icon(IconlyBold.delete, size: 20),
                color: Colours.danger,
                tooltip: 'Delete',
              ),
          ],
        ],
      ),
    );
  }
}
