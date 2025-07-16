import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:flutter/material.dart';

class WideImagePicker extends StatefulWidget {
  const WideImagePicker({this.imageUrl, super.key});

  final String? imageUrl;
  @override
  State<WideImagePicker> createState() => _WideImagePickerState();
}

class _WideImagePickerState extends State<WideImagePicker> {

  File? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final imagefile = await CoreUtils.pickImage();
        if (imagefile != null) {
          setState(() {
            image = imagefile;
          });
        }
      },
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colours.grey200,
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(image!, fit: BoxFit.cover),
                )
                : widget.imageUrl != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                )
                : const Center(child: Icon(Icons.add_a_photo, size: 32)),
      ),
    );
  }
}
