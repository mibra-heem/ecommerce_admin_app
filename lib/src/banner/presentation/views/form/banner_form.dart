import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/widgets/form_buttons_row.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/src/banner/data/models/banner_model.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/bloc/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class BannerForm extends StatefulWidget {
  const BannerForm({required this.isCreate, this.banner, super.key});

  final BannerEntity? banner;
  final bool isCreate;

  @override
  State<BannerForm> createState() => _BannerFormState();
}

class _BannerFormState extends State<BannerForm> {
  final formKey = GlobalKey<FormState>();
  File? image;
  String? imageUrl;
  bool? isActive;

  bool get imageChanged => !widget.isCreate && image != null;

  bool get isActiveChanged =>
      !widget.isCreate && widget.banner?.isActive != isActive;

  bool get nothingChanged => !imageChanged && !isActiveChanged;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.banner?.image;

    isActive = widget.banner?.isActive ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.isCreate;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            '${isCreate ? "Create" : "Edit"} Banner',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),

          /// Image Upload
          Text('Banner Image', style: context.text.titleSmall),
          Text(
            'Rectangle image 2:1 (1024x512) recommended. '
            'And max size should be 2MB.',
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
                            child: Image.file(image!, fit: BoxFit.fill),
                          )
                          : imageUrl != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl!,
                              fit: BoxFit.fill,
                            ),
                          )
                          : const Center(
                            child: Icon(Icons.add_a_photo, size: 32),
                          ),
                ),
              ),
              if (image != null || imageUrl != null)
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
                        imageUrl = null;
                        image = null;
                      });
                    },
                  ),
                ),
            ],
          ),

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

          /// Submit Button
          FormButtonsRow(
            actionButton: StatefulBuilder(
              builder: (context, refresh) {
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
                      final bloc = context.read<BannerBloc>();

                      // ✅ Call Create or Update here
                      if (isCreate) {
                        if (image != null) {
                          final banner = BannerModel(image: image!.path);
                          debugPrint('Banner Model Before Storing $banner');
                          bloc.add(StoreBannerEvent(banner));
                        }
                      } else {
                        if (nothingChanged) {
                          CoreUtils.showSnackbar(
                            context,
                            message: 'Nothing to update.',
                          );
                          return;
                        }
                        final updates = <String, dynamic>{};

                        if (imageChanged) {
                          updates['image'] = image;
                        }

                        if (isActiveChanged) {
                          updates['is_active'] = isActive;
                        }

                        debugPrint('Updates $updates');
                        if (updates.isNotEmpty) {
                          bloc.add(
                            UpdateBannerEvent(
                              id: widget.banner!.id!,
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
