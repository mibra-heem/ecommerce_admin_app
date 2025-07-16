import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({required super.image, super.id, super.isActive});

  const BannerModel.empty() : super.empty();

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      id: data['id'] as int?,
      image: data['image_url'] as String,
      isActive: CoreUtils.toBoolean(data['is_active'] as int),
    );
  }

  BannerModel copyWith({int? id, String? image, bool? isActive}) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {'image': image, 'is_active': isActive};
  }
}
