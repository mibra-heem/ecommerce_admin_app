import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/widgets/field_label.dart';
import 'package:ecommerce_admin_app/core/app/widgets/form_buttons_row.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/app/widgets/titled_drop_down_field.dart';
import 'package:ecommerce_admin_app/core/app/widgets/titled_input_field.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/category/data/models/category_model.dart';
import 'package:ecommerce_admin_app/src/category/domain/entities/category.dart';
import 'package:ecommerce_admin_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({required this.isCreate, this.category, super.key});

  final CategoryEntity? category;
  final bool isCreate;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  File? icon;
  String? iconUrl;
  int? categoryType = 0;
  int? selectedParentId;
  bool? isActive;

  bool get nameChanged =>
      !widget.isCreate &&
      widget.category?.name.trim() != nameController.text.trim();

  bool get descriptionChanged =>
      !widget.isCreate &&
      widget.category?.description?.trim() != descriptionController.text.trim();

  bool get iconChanged => !widget.isCreate && icon != null;

  bool get categoryTypeChanged =>
      !widget.isCreate && widget.category?.parentId != selectedParentId;

  bool get parentIdChanged =>
      !widget.isCreate && widget.category?.parentId != selectedParentId;

  bool get isActiveChanged =>
      !widget.isCreate && widget.category?.isActive != isActive;

  bool get nothingChanged =>
      !nameChanged &&
      !iconChanged &&
      !parentIdChanged &&
      !isActiveChanged &&
      !descriptionChanged;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.category?.name ?? '');
    descriptionController = TextEditingController(
      text: widget.category?.description ?? '',
    );
    iconUrl = widget.category?.icon;

    isActive = widget.category?.isActive ?? true;

    categoryType = widget.category?.parentId ?? 0;

    if (widget.category?.parentId != null) {
      categoryType = 1;
      selectedParentId = widget.category!.parentId;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.isCreate;
    final categories = context.read<CategoryProvider>().categories;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            '${isCreate ? "Create" : "Edit"} Category',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),

          /// Name
          TitledInputField(
            controller: nameController,
            title: 'Name',
            hintText: 'Electronics',
          ),

          const SizedBox(height: 20),

          /// Image Upload
          Text('Category Image', style: context.text.titleSmall),
          Text(
            'Square image (512x512) recommended. And max size should be 2MB.',
            style: context.text.labelSmall?.copyWith(
              overflow: TextOverflow.clip,
            ),
          ),

          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                onTap: () async {
                  final iconfile = await CoreUtils.pickImage();
                  if (iconfile != null) {
                    setState(() {
                      icon = iconfile;
                    });
                  }
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colours.grey200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      icon != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(icon!, fit: BoxFit.cover),
                          )
                          : iconUrl != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: ApiConst.baseUrl + iconUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Center(
                            child: Icon(Icons.add_a_photo, size: 32),
                          ),
                ),
              ),
              if (icon != null || iconUrl != null)
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      IconlyBold.delete,
                      color: Colours.danger,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        iconUrl = null;
                        icon = null;
                      });
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          /// Category Type (Radio)
          const FieldLabel(title: 'Category Type'),
          Row(
            children: [
              Radio<int>(
                value: 0,
                groupValue: categoryType,
                onChanged:
                    (val) => setState(() {
                      categoryType = val;
                      // selectedParentId = null;
                    }),
              ),
              const Text('Main Category'),
              const SizedBox(width: 16),
              Radio<int>(
                value: 1,
                groupValue: categoryType,
                onChanged: (val) => setState(() => categoryType = val),
              ),
              const Text('Sub Category'),
            ],
          ),

          /// Dropdown for Sub Category
          if (categoryType == 1) ...[
            const SizedBox(height: 20),

            TitledDropDownField(
              title: 'Select Parent Category',
              selectedId: selectedParentId,
              required: false,
              items: List.generate(categories.length, (index) {
                return DropdownMenuItem(
                  value: categories[index].id,
                  child: Text(categories[index].name),
                );
              }),
              onChanged: (id) {
                setState(() {
                  selectedParentId = id;
                });
              },
              overrideValidator: true,
              validator: (value) {
                if (categoryType == 1 && value == null) {
                  return 'Please select a parent category';
                }
                return null;
              },
            ),
          ],

          /// Active Switch (only for Edit)
          if (!isCreate) ...[
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Active Status'),
                Switch(
                  value: isActive!,
                  onChanged: (val) => setState(() => isActive = val),
                  activeColor: Colours.success,
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          /// Description
          TitledInputField(
            controller: descriptionController,
            title: 'Description',
            hintText: 'Short description...',
            maxLength: 150,
            maxLines: 3,
            required: false,
          ),

          const SizedBox(height: 20),

          /// Submit Button
          FormButtonsRow(
            actionButton: StatefulBuilder(
              builder: (context, refresh) {
                nameController.addListener(() => refresh(() {}));
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final bloc = context.read<CategoryBloc>();

                      // ✅ Call Create or Update here
                      if (isCreate) {
                        final category = CategoryModel(
                          name: nameController.text.trim(),
                          parentId: selectedParentId,
                          icon: icon!.path,
                          description: descriptionController.text.trim(),
                        );
                        debugPrint('Category Model Before Storing $category');
                        bloc.add(StoreCategoryEvent(category));
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
                        if (iconChanged) {
                          updates['icon'] = icon;
                        }
                        if (parentIdChanged) {
                          updates['parent_id'] = selectedParentId;
                        }
                        if (isActiveChanged) {
                          updates['is_active'] = isActive;
                        }
                        if (descriptionChanged) {
                          updates['description'] =
                              descriptionController.text.trim();
                        }
                        debugPrint('Updates $updates');
                        if (updates.isNotEmpty) {
                          bloc.add(
                            UpdateCategoryEvent(
                              id: widget.category!.id!,
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
