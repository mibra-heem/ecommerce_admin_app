import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/views/blurred_loading_view.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_admin_app/src/product/presentation/views/form/product_create_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductCreateView extends StatefulWidget {
  const ProductCreateView({super.key});

  @override
  State<ProductCreateView> createState() => _ProductCreateViewState();
}

class _ProductCreateViewState extends State<ProductCreateView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ProductCreateForm(),
            ),
          ),
        ),
        BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProdutStored) {
              CoreUtils.showSnackbar(context, 'Product created successfully.');
              context.pop();
            }
          },
          builder: (context, state) {
            if(state is StoringProduct){
              return const BlurredLoadingView(label: 'Creating Product');
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
