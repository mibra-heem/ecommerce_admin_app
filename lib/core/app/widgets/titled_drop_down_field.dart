import 'package:ecommerce_admin_app/core/app/widgets/field_label.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TitledDropDownField extends StatelessWidget {
  const TitledDropDownField({
    required this.title,
    required this.selectedId,
    required this.onChanged,
    required this.items,
    this.validator, // <-- Accept custom validator
    this.overrideValidator = false, // <-- Whether to override default
    this.required = true,
    super.key,
  });

  final String title;
  final int? selectedId;
  final List<DropdownMenuItem<int>>? items;
  final ValueChanged<int?> onChanged;
  final FormFieldValidator<int>? validator; // Custom validator
  final bool overrideValidator; // If true, use only custom
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(title: title, required: required,),
        DropdownButtonFormField<int>(
          isExpanded: true,
          value: selectedId,
          padding: const EdgeInsets.only(left: 8),
          hint: const Text('Electronics'),
          style: context.theme.textTheme.bodyLarge,
          borderRadius: BorderRadius.circular(20),
          menuMaxHeight: 200,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
          items: items,
          onChanged: onChanged,
          validator:
              overrideValidator
                  ? validator
                  : (value) {
                    if (value == null) {
                      return 'This field is required.';
                    }
                    return validator?.call(value);
                  },
        ),
      ],
    );
  }
}
