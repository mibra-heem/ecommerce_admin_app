import 'dart:io';

import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider();

  final List<File?> _images = [];
  List<File?> get images => _images;

  void addImage(File image) {
    _images.add(image);
    notifyListeners();
  }
}
