import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/views/blurred_loading_view.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:ecommerce_admin_app/src/category/presentation/views/form/category_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryFormView extends StatefulWidget {
  const CategoryFormView({super.key, this.category});

  final CategoryEntity? category;

  @override
  State<CategoryFormView> createState() => _CategoryFormViewState();
}

class _CategoryFormViewState extends State<CategoryFormView> {
  late final bool isCreate;

  @override
  void initState() {
    super.initState();

    isCreate = widget.category == null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CategoryForm(
                isCreate: isCreate, 
                category: widget.category,
              ),
            ),
          ),
        ),
        BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryStored) {
              CoreUtils.showSnackbar(
                context,
                'Category ${isCreate ? "created" : "updated"} successfully.',
              );
              context.pop();
            } else if (state is CategoryError) {
              CoreUtils.showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is StoringCategory) {
              return BlurredLoadingView(
                label: '${isCreate ? "Creating" : "Updating"} Category',
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
