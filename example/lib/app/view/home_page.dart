import 'package:flutter/material.dart';
import 'package:theme_genius/theme_genius.dart';

const list = <String>['System', 'Light', 'Dark'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropdownValue;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeGenius'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
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
              });
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            items: [
              DropdownMenuItem(
                value: list[0],
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_mode,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      list[0],
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: list[1],
                child: Row(
                  children: [
                    const Icon(
                      Icons.light_mode,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      list[1],
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: list[2],
                child: Row(
                  children: [
                    const Icon(
                      Icons.dark_mode,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      list[2],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
