import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce_admin_app/core/constants/storage_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/core/utils/typedef.dart';
import 'package:ecommerce_admin_app/src/auth/data/models/local_user_model.dart';
import 'package:ecommerce_admin_app/src/auth/domain/entities/local_user.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<void> cacheUserData(LocalUser user);
  Future<LocalUser> getUserCachedData();
}

class AuthLocalDataSrcImpl implements AuthLocalDataSource {
  const AuthLocalDataSrcImpl({required Box<dynamic> userBox})
    : _userBox = userBox;

  final Box<dynamic> _userBox;

  @override
  Future<void> cacheUserData(LocalUser user) async {
    try {
      await _userBox.put(
        StorageConst.user,
        (user as LocalUserModel).toMapLocal(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'cache-user-failed',
      );
    }
  }

  @override
  Future<LocalUser> getUserCachedData() async {
    try {
      final userMap = _userBox.get(StorageConst.user);
      final user = DataMap.from(userMap as Map);
      return LocalUserModel.fromMap(user);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'get-user-cache-failed',
      );
    }
  }
}
