import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:theme_genius/theme_genius.dart';

const list = ['System', 'Light', 'Dark'];
const iconList = [Icons.auto_mode, Icons.light_mode, Icons.dark_mode];

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(const App());
}

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropdownValue;
  String? themeModeText;

  @override
  void initState() {
    super.initState();
    _loadCurrentThemeMode();
  }

  Future<void> _loadCurrentThemeMode() async {
    final themeMode = await ThemeGenius.getThemeMode(context);

    final value = switch (themeMode) {
      ThemeMode.light => list[1],
      ThemeMode.dark => list[2],
      _ => list[0],
    };

    setState(() {
      dropdownValue = value;
      themeModeText = themeMode.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Current Theme Mode: $themeModeText',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Center(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  onChanged: (String? value) async {
                    final themeMode = switch (value) {
                      'Light' => ThemeMode.light,
                      'Dark' => ThemeMode.dark,
                      _ => ThemeMode.system,
                    };

                    await ThemeGenius.setThemeMode(themeMode);

                    setState(() {
                      dropdownValue = value;
                      themeModeText = themeMode.toString();
                    });
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  items: List.generate(
                    list.length,
                    (index) => DropdownMenuItem(
                      value: list[index],
                      child: Row(
                        children: [
                          Icon(iconList[index]),
                          const SizedBox(width: 8),
                          Text(list[index]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
