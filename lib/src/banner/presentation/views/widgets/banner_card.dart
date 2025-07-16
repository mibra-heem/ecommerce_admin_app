import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/card_buttons_row.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colours.grey900 : Colours.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Wide Image Preview
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: GestureDetector(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierColor: Colors.black.withAlpha(200),
                  builder: (_) {
                    return Dialog(
                      insetPadding: EdgeInsets.zero,
                      child: InteractiveViewer(
                        child: CachedNetworkImage(
                          imageUrl: ApiConst.baseUrl + banner.image,
                          fit: BoxFit.contain,
                          placeholder:
                              (_, _) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (_, _, _) => const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: CachedNetworkImage(
                imageUrl: ApiConst.baseUrl + banner.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder:
                    (_, __) => Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                errorWidget:
                    (_, __, ___) => Container(
                      height: 150,
                      color: Colours.grey300,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colours.grey600,
                        size: 32,
                      ),
                    ),
              ),
            ),
          ),

          // Info + Actions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${banner.id}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                                  ? Colours.success.withAlpha(25)
                                  : Colours.disable.withAlpha(25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          banner.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                banner.isActive
                                    ? Colours.success
                                    : Colours.disable,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                CardActionButtons(
                  isViewOn: false,
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
