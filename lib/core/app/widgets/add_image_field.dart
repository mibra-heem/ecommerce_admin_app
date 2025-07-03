import 'dart:io';

import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AddImageField extends StatefulWidget {
  const AddImageField({
    required this.title,
    this.images = const [],
    this.hintText,
    this.hintStyle,
    super.key,
  });

  final String title;
  final List<File?> images;
  final String? hintText;
  final TextStyle? hintStyle;

  @override
  State<AddImageField> createState() => _AddImageFieldState();
}

class _AddImageFieldState extends State<AddImageField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hintText!,
                    style: context.theme.textTheme.titleSmall,
                  ),
                  const Text(
                    'Square image recommended - maximum size 2MB',
                    style: TextStyle(color: Colours.grey600, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed:
                  widget.images.length >= 5
                      ? null
                      : () async {
                        final image = await CoreUtils.pickImage();
                        if (image != null) {
                          setState(() {
                            widget.images.add(image);
                          });
                        }
                      },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      widget.images.isEmpty
                          ? context.color.secondary
                          : widget.images.length < 5
                          ? Colours.primaryLight
                          : Colours.grey600,
                ),
                child: Icon(
                  Icons.add_a_photo_rounded,
                  color:
                      widget.images.isEmpty
                          ? context.color.onSecondary
                          : Colours.grey100,
                ),
              ),
            ),
          ],
        ),
        if (widget.images.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5,
                children: [
                  const Text(
                    'Added Images',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      '${widget.images.length}/5',
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: Colours.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Image.file(
                                  widget.images[index]!,
                                ),
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            widget.images[index]!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
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
                              widget.images.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
