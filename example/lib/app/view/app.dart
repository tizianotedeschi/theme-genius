import 'package:example/app/app.dart';
import 'package:flutter/material.dart';
import 'package:theme_genius/theme_genius.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeGeniusWrapper(
      builder: (themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const HomePage(),
        );
      },
      // defaultThemeMode: ThemeMode.dark,
      // placeholder: const Scaffold(
      //   body: Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }
}
