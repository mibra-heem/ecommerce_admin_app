import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/app_dialog_box.dart';
import 'package:ecommerce_admin_app/core/app/widgets/card_buttons_row.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/widgets/view_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, required this.index, super.key});

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  height: 70,
                  width: 70,
                  imageUrl:
                      (product.images?.isNotEmpty ?? false)
                          ? ApiConst.baseUrl + product.images!.first
                          : '',
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                  errorWidget:
                      (_, imageUrl, _) => Container(
                        height: 70,
                        width: 70,
                        color: Colours.grey200,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported),
                      ),
                ),
              ),
              const SizedBox(width: 14),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Product ID
                    Text(
                      'ID: ${product.id}',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            context.isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Price & Category Row
                    Row(
                      children: [
                        Text(
                          'Rs. ${product.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colours.primaryLight,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colours.primaryLight.withAlpha(22),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            product.category.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colours.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            product.description ?? 'No description available.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: context.isDarkMode ? Colours.grey500 : Colours.grey700,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 14),

          // Action Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status + Stock
              Row(
                children: [
                  Icon(
                    index.isOdd
                        ? IconlyBold.tick_square
                        : IconlyBold.close_square,
                    color: index.isOdd ? Colours.success : Colours.disable,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    index.isOdd ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 12,
                      color: index.isOdd ? Colours.success : Colours.disable,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.green[50] : Colors.red[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      index.isEven ? 'In Stock' : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: index.isEven ? Colours.success : Colours.danger,
                      ),
                    ),
                  ),
                ],
              ),

              // View | Edit | Delete Buttons
              CardActionButtons(
                onView: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) {
                      return ViewModalBottomSheet(
                        product: product,
                        index: index,
                      );
                    },
                  );
                },
                onEdit: () {
                  context.pushNamed(
                    RouteName.productEdit,
                    pathParameters: {'id': product.id!},
                    extra: product,
                  );
                },
                onDelete: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) {
                      return AppDialogBox.alert(
                        title: 'Remove',
                        content:
                            'Are you sure you want to '
                            'delete this item?',
                        onConfirm: () {
                          context.read<ProductBloc>()
                            ..add(DeleteProductEvent(product.id!))
                            ..add(const GetProductsEvent());
                          context.pop();
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
