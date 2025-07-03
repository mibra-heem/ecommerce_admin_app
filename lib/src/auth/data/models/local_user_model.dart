import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser{
  const LocalUserModel({
    required super.uid, 
    required super.email, 
    required super.name, 
    super.image,
    super.bio,
    super.activeChatId,
    super.fcmToken,
  });

  const LocalUserModel.empty() : super.empty();

  LocalUserModel.fromMap(SDMap map) : super(
    uid:  map['uid'] as String,
    email: map['email'] as String,
    name: map['name'] as String,
    image: map['image'] as String?,
    bio: map['bio'] as String?,
    activeChatId: map['activeChatId']  as String?,
    fcmToken: map['fcmToken']  as String?,

  );

  LocalUserModel copyWith({
    String? uid, 
    String? email,
    String? name, 
    String? image,
    String? bio,
    String? activeChatId,
    String? fcmToken,
  }){
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email, 
      name: name ?? this.name,
      image: image ?? this.image,
      bio: bio ?? this.bio,
      activeChatId: activeChatId ?? this.activeChatId,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  SDMap toMap(){
    return {
      'uid' : uid,
      'email' : email,
      'name' : name,
      'image' : image,
      'bio' : bio,
      'activeChatId' : activeChatId,
      'fcmToken' : fcmToken,
    };
  }

  SDMap toMapLocal(){
    return {
      'uid' : uid,
      'email' : email,
      'name' : name,
      'image' : image,
      'bio' : bio,
      'activeChatId' : activeChatId,
      'fcmToken' : fcmToken,
    };
  }

}
