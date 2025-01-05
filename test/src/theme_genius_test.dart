import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_genius/theme_genius.dart';

Widget defaultTestBuilder(ThemeMode themeMode) {
  return MaterialApp(
    themeMode: themeMode,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: const Scaffold(
      body: Text('ThemeGeniusWrapper'),
    ),
  );
}

void main() {
  Widget buildTestApp({
    Widget Function(ThemeMode) builder = defaultTestBuilder,
    ThemeMode defaultThemeMode = ThemeMode.system,
    Widget? placeholder,
  }) {
    return ThemeGeniusWrapper(
      builder: builder,
      defaultThemeMode: defaultThemeMode,
      placeholder: placeholder,
    );
  }

  group('ThemeGeniusWrapper', () {
    testWidgets(
      'displays placeholder while loading',
      (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            placeholder: const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
      },
    );
  });
}
