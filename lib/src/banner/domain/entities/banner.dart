import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  const BannerEntity({
    required this.image,
    this.id,
    this.isActive = true,
  });

  const BannerEntity.empty()
    : this(image: 'banner.image');

  final int? id;
  final String image;
  final bool isActive;

  @override
  List<Object?> get props => [id, image, isActive];

  @override
  String toString() {
    return 'Banner{id: $id, image: $image, isActive: $isActive}';
  }
}
