import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An inherited widget that provides the theme mode for the app.
class ThemeGenius extends InheritedWidget {
  /// Creates a [ThemeGenius] widget.
  ///
  /// The [themeMode] parameter specifies the initial theme mode for the app.
  const ThemeGenius({
    required super.child,
    this.themeMode = ThemeMode.system,
    super.key,
  });

  /// The initial theme mode for the app.
  final ThemeMode themeMode;

  /// Returns the [ThemeGenius] instance from the given [BuildContext].
  static ThemeGenius? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeGenius>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  /// Returns a [Future] that completes with the current theme mode.
  static Future<ThemeMode> getThemeMode(BuildContext context) async {
    return Future.delayed(
      Duration.zero,
      () => ThemeGenius.of(context)?.themeMode ?? ThemeMode.system,
    );
  }

  /// Sets the theme mode and returns a [Future] that completes with a [bool]
  /// indicating whether the operation was successful.
  static Future<bool> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('THEME_MODE_GENIUS', themeMode.toString());
  }

  /// Loads the theme mode from shared preferences and returns a [Future] that
  /// completes with the loaded theme mode.
  static Future<ThemeMode?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('THEME_MODE_GENIUS');

    return result != null ? _parseThemeMode(result) : null;
  }

  /// Returns `true` if the current brightness is light, `false` otherwise.
  static bool isBrightnessLight(BuildContext context) {
    final theme = ThemeGenius.of(context)?.themeMode ?? ThemeMode.system;

    if (theme == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        return true;
      } else {
        return false;
      }
    }

    return theme == ThemeMode.light;
  }

  static ThemeMode? _parseThemeMode(String value) {
    return switch (value) {
      'ThemeMode.system' => ThemeMode.system,
      'ThemeMode.light' => ThemeMode.light,
      'ThemeMode.dark' => ThemeMode.dark,
      _ => null,
    };
  }
}
