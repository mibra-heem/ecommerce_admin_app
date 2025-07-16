import 'dart:io';

import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/widgets/add_image_field.dart';
import 'package:ecommerce_admin_app/core/app/widgets/form_buttons_row.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/app/widgets/titled_drop_down_field.dart';
import 'package:ecommerce_admin_app/core/app/widgets/titled_input_field.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/product/data/models/product_model.dart';
import 'package:ecommerce_admin_app/src/product/domain/entities/product.dart';
import 'package:ecommerce_admin_app/src/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({required this.isCreate, super.key, this.product});

  final Product? product;
  final bool isCreate;
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;
  List<File?> images = [];
  int? selectedCategoryId;

  bool get nameChanged =>
      !widget.isCreate &&
      widget.product?.name.trim() != nameController.text.trim();

  bool get priceChanged =>
      !widget.isCreate &&
      widget.product?.price.toString().trim() != priceController.text.trim();

  bool get categoryChanged =>
      !widget.isCreate && widget.product?.category.id != selectedCategoryId;

  bool get imageChanged => images.isNotEmpty;

  bool get descriptionChanged =>
      !widget.isCreate &&
      widget.product?.description?.trim() != descriptionController.text.trim();

  bool get nothingChanged =>
      !nameChanged &&
      !priceChanged &&
      !categoryChanged &&
      !descriptionChanged &&
      !imageChanged;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? '');
    priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    selectedCategoryId = widget.product?.category.id;
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
    final categories = context.read<CategoryProvider>().categories;

    final isCreate = widget.isCreate;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            '${isCreate ? "Create" : "Edit"} Product',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          TitledInputField(
            controller: nameController,
            title: 'Name',
            hintText: 'Earbuds Pro 1.O',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
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
              Expanded(
                child: TitledDropDownField(
                  title: 'Category',
                  selectedId: selectedCategoryId,
                  items: List.generate(categories.length, (index) {
                    return DropdownMenuItem(
                      value: categories[index].id,
                      child: Text(categories[index].name),
                    );
                  }),
                  onChanged: (id) {
                    setState(() {
                      selectedCategoryId = id;
                    });
                  },
                ),
              ),
            ],
          ),
          AddImageField(
            images: images,
            title: 'Image',
            hintText: 'Select Image From Gallery',
            onAddImage:
                images.length >= 5
                    ? null
                    : () async {
                      final image = await CoreUtils.pickImage();
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
            onRemoveImage: (i) {
              setState(() {
                images.removeAt(i);
              });
            },
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
            actionButton: StatefulBuilder(
              builder: (context, refresh) {
                nameController.addListener(() => refresh(() {}));
                priceController.addListener(() => refresh(() {}));
                descriptionController.addListener(() => refresh(() {}));
                return RoundedButton(
                  isCreate ? 'Create' : 'Update',
                  fontSize: 14,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  buttonColor:
                      isCreate
                          ? Colours.primaryLight
                          : nothingChanged
                          ? Colours.disable
                          : Colours.primaryLight,
                  labelColor: Colours.grey100,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final bloc = context.read<ProductBloc>();
                      if (isCreate) {
                        final category = categories.firstWhere(
                          (c) => c.id == selectedCategoryId,
                        );
                        final product = ProductModel(
                          name: nameController.text.trim(),
                          price: int.parse(priceController.text.trim()),
                          category: category,
                          images:
                              images.isNotEmpty
                                  ? images
                                      .whereType<File>()
                                      .map((file) => file.path)
                                      .toList()
                                  : null,
                          description: descriptionController.text.trim(),
                        );
                        debugPrint(
                          'Product Data before send store request $product',
                        );
                        bloc.add(StoreProductEvent(product));
                      } else {
                        if (nothingChanged) {
                          CoreUtils.showSnackbar(
                            context,
                            message: 'Nothing to update.',
                          );
                          return;
                        }
                        final updates = <String, dynamic>{};

                        if (nameChanged) {
                          updates['name'] = nameController.text.trim();
                        }
                        if (priceChanged) {
                          updates['price'] = int.parse(
                            priceController.text.trim(),
                          );
                        }
                        if (categoryChanged) {
                          updates['category_id'] = selectedCategoryId;
                        }
                        if (imageChanged) updates['images'] = images;
                        if (descriptionChanged) {
                          updates['description'] =
                              descriptionController.text.trim();
                        }
                        debugPrint('Updates Map : $updates');
                        if (updates.isNotEmpty) {
                          bloc.add(
                            UpdateProductEvent(
                              id: widget.product!.id!,
                              updates: updates,
                            ),
                          );
                        }
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
