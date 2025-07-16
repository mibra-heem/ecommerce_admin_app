import 'package:ecommerce_admin_app/core/constants/storage_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class ThemeLocalDataSrc {
  const ThemeLocalDataSrc();

  Future<int> loadThemeMode();
  Future<void> cacheThemeMode(int index);
}

class ThemeLocalDataSrcImpl implements ThemeLocalDataSrc {
  const ThemeLocalDataSrcImpl({required Box<dynamic> themeBox})
    : _themeBox = themeBox;

  final Box<dynamic> _themeBox;

  @override
  Future<void> cacheThemeMode(int index) async {
    try {
      await _themeBox.put(StorageConst.theme, index);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'cache-theme-mode-failed',
      );
    }
  }

  @override
  Future<int> loadThemeMode() async {
    try {
      return _themeBox.get(StorageConst.theme) as int? ?? ThemeMode.light.index;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(
        message: e.toString(),
        statusCode: 'load-theme-mode-failed',
      );
    }
  }
}
