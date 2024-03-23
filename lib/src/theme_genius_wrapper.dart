import 'package:flutter/material.dart';
import 'package:theme_genius/src/theme_genius.dart';
import 'package:theme_genius/src/theme_genius_mode.dart';

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
  final ThemeGeniusMode _themeGeniusMode = ThemeGeniusMode();
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();

    _themeGeniusMode.addListener(() {
      setState(() => _themeMode = _themeGeniusMode.themeMode);
    });
  }

  Future<ThemeMode> _init() async {
    final oldThemeMode = await ThemeGenius.loadThemeMode();

    if (oldThemeMode != null) {
      _themeGeniusMode.themeMode = oldThemeMode;
      _themeMode = oldThemeMode;

      return oldThemeMode;
    }

    _themeGeniusMode.themeMode = widget.defaultThemeMode;
    _themeMode = widget.defaultThemeMode;

    return widget.defaultThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) => snapshot.hasData
          ? ThemeGenius(
              themeGeniusMode: _themeGeniusMode,
              child: widget.builder(_themeMode),
            )
          : widget.placeholder ?? Container(),
    );
  }
}
