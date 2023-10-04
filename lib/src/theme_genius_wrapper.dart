import 'package:flutter/material.dart';
import 'package:theme_genius/src/theme_genius.dart';

/// A wrapper widget that provides the theme mode for the app.
class ThemeGeniusWrapper extends StatefulWidget {
  /// Creates a [ThemeGeniusWrapper] widget.
  ///
  /// The [builder] parameter specifies a builder function that returns a widget
  /// depending on the current [ThemeMode].
  ///
  /// The [defaultThemeMode] parameter specifies the default theme mode.
  ///
  /// The [placeholder] parameter specifies a widget to display while the theme
  /// mode is being loaded.
  const ThemeGeniusWrapper({
    required this.builder,
    this.defaultThemeMode = ThemeMode.system,
    this.placeholder,
    super.key,
  });

  /// A builder function that returns a widget depending on the current
  /// [ThemeMode].
  final Widget Function(ThemeMode themeMode) builder;

  /// The default theme mode.
  final ThemeMode defaultThemeMode;

  /// A widget to display while the theme mode is being loaded.
  final Widget? placeholder;

  @override
  State<ThemeGeniusWrapper> createState() => _ThemeGeniusWrapperState();
}

class _ThemeGeniusWrapperState extends State<ThemeGeniusWrapper> {
  late ThemeMode _themeMode;

  Future<ThemeMode> _init() async {
    final oldThemeMode = await ThemeGenius.loadThemeMode();

    if (oldThemeMode != null) {
      _update(oldThemeMode);
      return oldThemeMode;
    }

    await ThemeGenius.setThemeMode(widget.defaultThemeMode);

    _update(widget.defaultThemeMode);
    return widget.defaultThemeMode;
  }

  void _update(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) => snapshot.hasData
          ? ThemeGenius(
              themeMode: _themeMode,
              child: widget.builder(_themeMode),
            )
          : widget.placeholder ?? Container(),
    );
  }
}
