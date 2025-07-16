import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/views/loading_view.dart';
import 'package:ecommerce_admin_app/core/app/widgets/app_dialog_box.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/category/presentation/views/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          spacing: 10,
          children: [Icon(IconlyBold.category), Text('Categories')],
        ),
        actionsPadding: const EdgeInsets.only(right: 6),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RouteName.categoryCreate);
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
            await context.read<CategoryProvider>().getCategoriesHandler();
          },
          child: Consumer<CategoryProvider>(
            builder: (_, provider, _) {
              if (provider.isLoading) {
                return const LoadingView();
              } else if (!provider.isLoading &&
                  provider.categories.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.categories.length,
                  itemBuilder: (_, index) {
                    debugPrint('Building the Category Card $index');
                    final category = provider.categories[index];
                    return CategoryCard(
                      category: category,
                      onEdit: () {
                        context.pushNamed(
                          RouteName.categoryEdit,
                          pathParameters: {'id': '${category.id}'},
                          extra: category,
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
                                  'delete this category?',
                              onConfirm: () {
                                context.read<CategoryProvider>()
                                  ..deleteCategoryHandler(category.id!)
                                  ..getCategoriesHandler();
                                context.pop();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
              return const Center(child: Text('No, Categories are found.'));
            },
          ),
        ),
      ),
    );
  }
}
