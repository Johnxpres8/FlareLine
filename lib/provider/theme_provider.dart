import 'package:flareline/provider/base_provider.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends BaseProvider {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;

  void toggleThemeMode() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
