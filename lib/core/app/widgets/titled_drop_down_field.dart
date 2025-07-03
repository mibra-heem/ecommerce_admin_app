import 'package:ecommerce_admin_app/core/app/widgets/field_label.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/category/presentation/provider/category_provider.dart';
import 'package:ecommerce_admin_app/src/product/presentation/provider/product_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitledDropDownField extends StatelessWidget {
  const TitledDropDownField({
    required this.title,
    this.selectedCategoryId,
    this.required = true,
    this.isTextArea = false,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    super.key,
  });

  final String title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final int? selectedCategoryId;
  final bool required;
  final bool isTextArea;

  @override
  Widget build(BuildContext context) {
    debugPrint('Categories => ${sl<CategoryProvider>().categories}');
    final categories = sl<CategoryProvider>().categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(title: title, required: required),
        const SizedBox(height: 10),
        Consumer<ProductCreateProvider>(
          builder: (_, provider, __) {
            return DropdownButtonFormField<int>(
              value: provider.selectedCategoryId,
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
                isDense: true, // makes it compact
              ),
              items: List.generate(categories.length, (index) {
                return DropdownMenuItem(
                  value: categories[index].id,
                  child: Text(categories[index].name),
                );
              }),
              onChanged: (v) {
                debugPrint('From OnChanged Method the value is => $v');
                provider.selectedCategoryId = v;
              },
              validator: (value) {
                if (!required) return null;
                if (value == null) {
                  return 'This field is required.';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}
