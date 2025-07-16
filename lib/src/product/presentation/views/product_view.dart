import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/views/loading_view.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> brands = ['Nike', 'Adidas', 'Puma'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          spacing: 10,
          children: [Icon(LucideIcons.shoppingBag), Text('Products')],
        ),
        actionsPadding: const EdgeInsets.only(right: 6),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RouteName.productCreate);
            },
            icon: const Row(
              spacing: 5,
              children: [
                Text(
                  'Add',
                  style: TextStyle(
                    color: Colours.grey100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(FontAwesomeIcons.plus),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const GetProductsEvent());
          },
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              debugPrint('${state.runtimeType}');
            },
            builder: (context, state) {
              if (state is LoadingProducts) {
                return const LoadingView();
              } else if (state is ProductLoaded) {
                if (state.products.isEmpty) {
                  return const Center(child: Text('No, Products are found.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.products.length,
                  itemBuilder: (_, index) {
                    debugPrint('Building the Product Card $index');
                    final product = state.products[index];
                    return ProductCard(product: product, index: index);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
