import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    final hasImages = product.images?.isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Product Images (Carousel)
            if (hasImages)
              Center(
                child: SizedBox(
                  height: 220,
                  width: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // Apply to the whole carousel
                    child: CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        enableInfiniteScroll: product.images!.length > 1,
                        autoPlay: product.images!.length > 1,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayCurve: Curves.easeInOut,
                      ),
                      items:
                          product.images!.map((img) {
                            return GestureDetector(
                              onTap: () {
                                _openFullScreenImage(
                                  context,
                                  ApiConst.baseUrl + img,
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: ApiConst.baseUrl + img,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder:
                                    (_, _) => const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                errorWidget:
                                    (_, _, _) => Container(
                                      color: Colours.grey200,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 40,
                                      ),
                                    ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 180,
                color: Colours.grey200,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, size: 40),
              ),

            const SizedBox(height: 16),

            // ✅ Product Name & ID
            Text(
              product.name,
              style: context.text.titleLarge?.copyWith(
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

            // ✅ Price & Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price}',
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

            // ✅ Stock & Status (Same as before)
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
                  product.isActive ? Icons.toggle_on : Icons.toggle_off,
                  color: product.isActive ? Colours.success : Colours.danger,
                  size: 24,
                ),
                const SizedBox(width: 6),
                Text(
                  product.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: product.isActive ? Colours.success : Colours.danger,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ Description
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

  void _openFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder:
            (_) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
              ),
              body: Center(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (_, _) => const CircularProgressIndicator(),
                    errorWidget:
                        (_, _, _) =>
                            const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
