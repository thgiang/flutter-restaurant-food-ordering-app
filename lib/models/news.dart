import 'package:flutter/material.dart';

class News with ChangeNotifier {
  double _fontSize = 1;

  set fontSize(newValue) {
    _fontSize = newValue;
    notifyListeners();
  }

  double get fontSize => _fontSize * 30;

  double get sliderFontSize => _fontSize;
}