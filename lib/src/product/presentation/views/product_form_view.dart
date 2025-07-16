import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/views/blurred_loading_view.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/form/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key, this.product});

  final Product? product;

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  late final bool isCreate;

  @override
  void initState() {
    super.initState();

    isCreate = widget.product == null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ProductForm(isCreate: isCreate, product: widget.product),
            ),
          ),
        ),
        BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProdutStored) {
              CoreUtils.showSnackbar(
                context,
                'Product ${isCreate ? "created" : "updated"} successfully.',
              );
              context.pop();
            } else if (state is ProductError) {
              CoreUtils.showSnackbar(context, state.message);
              // context.pop();
            }
          },
          builder: (context, state) {
            if (state is StoringProduct) {
              return BlurredLoadingView(
                label: '${isCreate ? "Creating" : "Updating"} Product',
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
