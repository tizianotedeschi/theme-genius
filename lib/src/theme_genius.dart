import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_genius/src/theme_genius_mode.dart';
import 'package:theme_genius/theme_genius.dart';

/// An inherited widget that provides the theme mode for the app.
class ThemeGenius extends InheritedWidget {
  /// Creates a [ThemeGenius] widget.
  ///
  /// The [themeGeniusMode] parameter specifies the [ThemeGeniusMode] instance
  const ThemeGenius({
    required super.child,
    required this.themeGeniusMode,
    super.key,
  });

  /// The initial theme mode for the app.
  final ThemeGeniusMode themeGeniusMode;

  /// Returns the current theme mode.
  ThemeMode get themeMode => themeGeniusMode.themeMode;

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
      () {
        if (!context.mounted) return ThemeMode.system;
        return ThemeGenius.of(context)?.themeMode ?? ThemeMode.system;
      },
    );
  }

  /// Sets the new theme mode to the shared preferences and updates the theme
  /// mode for the app.
  static Future<void> setThemeMode(
    BuildContext context, {
    required ThemeMode themeMode,
  }) async {
    final currentThemeMode = ThemeGenius.of(context)?.themeMode;
    if (currentThemeMode == themeMode) return;

    ThemeGenius.of(context)?.themeGeniusMode.setThemeMode(themeMode);
    return SharedPreferencesAsync().setString(
      'THEME_MODE_GENIUS',
      themeMode.toString(),
    );
  }

  /// Loads the old theme mode from shared preferences and returns a [Future]
  /// that completes with the loaded theme mode.
  static Future<ThemeMode?> loadThemeMode() async {
    final result = await SharedPreferencesAsync().getString(
      'THEME_MODE_GENIUS',
    );
    return result != null ? _parseThemeMode(result) : null;
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
