import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_genius/theme_genius.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

Widget defaultTestBuilder(ThemeMode themeMode) {
  return MaterialApp(
    themeMode: themeMode,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: Scaffold(
      body: ElevatedButton(
        onPressed: () {
          final theme =
              themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.light;
          ThemeGenius.setThemeMode(theme);
        },
        child: const Text('Change theme'),
      ),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

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

    testWidgets(
      'displays child widget after loading',
      (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            builder: (themeMode) => MaterialApp(
              themeMode: themeMode,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: Scaffold(
                body: Center(
                  child: Text('Theme mode: $themeMode'),
                ),
              ),
            ),
            defaultThemeMode: ThemeMode.light,
          ),
        );

        await tester.pump();
        expect(find.text('Theme mode: ThemeMode.light'), findsOneWidget);
      },
    );
  });
}
