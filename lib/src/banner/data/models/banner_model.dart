import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.image,
    super.id,
    super.isActive,
  });

  const BannerModel.empty() : super.empty();

  factory BannerModel.fromJson(Map<String, dynamic> data) {
    return BannerModel(
      id: data['id'] as int?,
      image: data['image'] as String,
      isActive: data['is_active'] as bool,
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
    return {'id': id, 'is_active': isActive, 'image': image};
  }
}
