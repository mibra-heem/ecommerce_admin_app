import 'dart:io';

import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/widgets/add_image_field.dart';
import 'package:ecommerce_admin_app/core/app/widgets/field_label.dart';
import 'package:ecommerce_admin_app/core/app/widgets/form_buttons_row.dart';
import 'package:ecommerce_admin_app/core/app/widgets/titled_input_field.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/product/data/models/product_model.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCreateForm extends StatefulWidget {
  const ProductCreateForm({super.key});

  @override
  State<ProductCreateForm> createState() => _ProductCreateFormState();
}

class _ProductCreateFormState extends State<ProductCreateForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  List<File?> images = [];

  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    debugPrint('initState ');
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Whole Widget ......');
    final categories = sl<CategoryProvider>().categories;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          const Text(
            'Create Product',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TitledInputField(
            controller: nameController,
            title: 'Name',
            hintText: 'Earbuds Pro 1.O',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TitledInputField(
                  controller: priceController,
                  enableOnlyNumbers: true,
                  title: 'Price',
                  counterText: '',
                  hintText: 'Rs. 4,999',
                  maxLength: 6,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel(title: 'Category'),
                    StatefulBuilder(
                      builder: (context, setState) {
                        debugPrint('Building DropdownButtonFormField ......');
                        return DropdownButtonFormField<int>(
                          value: selectedCategoryId,
                          padding: const EdgeInsets.only(left: 8),
                          hint: Text(
                            'Electronics',
                            style: context.theme.textTheme.titleMedium,
                          ),
                          style: context.theme.textTheme.bodyLarge,
                          borderRadius: BorderRadius.circular(20),
                          menuMaxHeight: 200,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            isDense: true,
                          ),
                          items: List.generate(categories.length, (index) {
                            return DropdownMenuItem(
                              value: categories[index].id,
                              child: Text(categories[index].name),
                            );
                          }),
                          onChanged: (v) {
                            debugPrint(
                              'From OnChanged Method the value is => $v',
                            );
                            setState(() {
                              selectedCategoryId = v;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This field is required.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          AddImageField(
            images: images,
            title: 'Image',
            hintText: 'Select Image From Gallery',
          ),
          TitledInputField(
            controller: descriptionController,
            title: 'Description',
            hintText:
                'Earbuds Pro 1.O is light & perfect fit for your'
                ' ears ...',
            maxLength: 1200,
            maxLines: 6,
            counterStyle: const TextStyle(
              color: Colours.primaryLight,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
            required: false,
          ),
          FormButtonsRow(
            mainButtonLabel: 'Create',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                debugPrint('selectedCategoryId => $selectedCategoryId');
                final category = categories.firstWhere(
                  (c) => c.id == selectedCategoryId,
                );
                final product = ProductModel(
                  name: nameController.text.trim(),
                  price: int.parse(priceController.text.trim()),
                  category: category,
                  image: images.isNotEmpty ? images[0]!.path : null,
                  description: descriptionController.text.trim(),
                );
                Provider.of<ProductBloc>(
                  context,
                  listen: false,
                ).add(StoreProductEvent(product));
              }
            },
          ),
        ],
      ),
    );
  }
}
