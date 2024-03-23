import 'package:flutter/material.dart';

/// A ChangeNotifier that provides the theme mode for the app.
class ThemeGeniusMode extends ChangeNotifier {
  /// The current theme mode.
  ThemeMode themeMode = ThemeMode.system;

  /// Sets the theme mode.
  void setThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }
}
