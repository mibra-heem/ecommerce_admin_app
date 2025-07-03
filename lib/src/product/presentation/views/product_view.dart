import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/card_buttons_row.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/product/presentation/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProductsHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (_, provider, __) {
        return SafeArea(
          child: Stack(
            alignment: const Alignment(0.9, 0.9),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.color.onSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.list, size: 28),
                          Text(
                            'List of products',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return Container(
                            height: 220,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colours.black, Colours.grey900],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              spacing: 10,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        height: 70,
                                        width: 70,
                                        imageUrl:
                                            ApiConst.baseUrl + product.image!,
                                        placeholder: (context, url) {
                                          return const CircularProgressIndicator();
                                        },
                                        errorWidget: (
                                          context,
                                          imageUrl,
                                          error,
                                        ) {
                                          return const Placeholder();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5,
                                        children: [
                                          Text(
                                            product.name,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${product.price}',
                                            style: const TextStyle(
                                              color: Colours.primaryLight,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  product.description!,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const CardButtonsRow(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                tooltip: 'Add a new product',
                onPressed: () {
                  context.pushNamed(RouteName.productCreate);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }
}
