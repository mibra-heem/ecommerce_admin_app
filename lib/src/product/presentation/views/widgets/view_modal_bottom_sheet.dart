import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/expandable_text.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ViewModalBottomSheet extends StatelessWidget {
  const ViewModalBottomSheet({
    required this.product,
    required this.index,
    super.key,
  });

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final hasImage = product.images?.isNotEmpty ?? false;
    final imageUrl = hasImage ? ApiConst.baseUrl + product.images!.first : null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                    hasImage
                        ? Image.network(
                          imageUrl!,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                        : Container(
                          height: 180,
                          color: Colours.grey200,
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_not_supported),
                        ),
              ),
            ),
            const SizedBox(height: 16),

            // Product Name & ID
            Text(
              product.name,
              style: context.text.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ID: ${product.id}',
              style: const TextStyle(
                color: Colours.grey600,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // Price & Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs. ${product.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colours.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Chip(
                  label: Text(product.category.name),
                  backgroundColor: Colors.blue.shade50,
                  labelStyle: const TextStyle(
                    color: Colours.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stock & Status
            Row(
              children: [
                Icon(
                  index.isOdd
                      ? IconlyBold.tick_square
                      : IconlyBold.close_square,
                  color: index.isOdd ? Colours.success : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  index.isOdd ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: index.isOdd ? Colours.success : Colours.danger,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  index.isEven ? Icons.toggle_on : Icons.toggle_off,
                  color: index.isEven ? Colours.success : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 6),
                Text(
                  index.isEven ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: index.isEven ? Colours.success : Colours.disable,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Rating, Sold, and Reviews
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text('4.5'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.shopping_bag, size: 20),
                    SizedBox(width: 4),
                    Text('Sold: 5k'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.reviews, size: 20),
                    SizedBox(width: 4),
                    Text('Good Product Reviews'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Description
            Text(
              'Description',
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            ExpandableText(
              text: product.description ?? 'No description available',
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
