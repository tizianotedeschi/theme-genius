# ThemeGenius

<!-- ![coverage][coverage_badge] -->

[![version][version-badge]][package]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A Flutter package that provides a simple way to manage theme modes in your app.

## Installation 💻

**❗ In order to start using ThemeGenius you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

- Install via `flutter pub add`:

```sh
dart pub add theme_genius
```

- Or add this to your `pubspec.yaml`:

```yaml
dependencies:
  theme_genius: ^1.0.0
```

---

## Usage 📖

- Import the `ThemeGeniusWrapper` widget, wrap `MaterialApp` with it:

```dart
import 'package:theme_genius/theme_genius.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeGeniusWrapper(
      builder: (themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const MyHomePage(
            title: 'Flutter Demo Home Page',
          ),
        );
      },
    );
  }
}
```

- Get the current `themeMode` with:

```dart
final themeMode = await ThemeGenius.getThemeMode(context);

```

- Change and save the `themeMode` with:

```dart
final themeMode = ThemeMode.dark;
await ThemeGenius.setThemeMode(themeMode);

```

- Load the saved `themeMode` with:

```dart
final themeMode = await ThemeGenius.loadThemeMode();

```

Check the `example` folder for a complete example.

---

## Extra 📖

- Set the `defaultThemeMode` in `ThemeGeniusWrapper` with:

```dart
@override
Widget build(BuildContext context) {
  return ThemeGeniusWrapper(
    builder: (themeMode) {
      return MaterialApp(...);
    },
    defaultThemeMode: ThemeMode.dark,
  );
}
```

- Set a custom `placeholder` (a widget to display while the theme mode is being loaded) in `ThemeGeniusWrapper` with:

```dart
@override
Widget build(BuildContext context) {
  return ThemeGeniusWrapper(
    builder: (themeMode) {
      return MaterialApp(...);
    },
    placeholder: const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
```

---

## Continuous Integration 🤖

Theme Genius comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

## License 📄

MIT © 2012-2023 Scott Chacon and others

[version-badge]: https://img.shields.io/pub/v/theme_genius
[package]: https://pub.dev/packages/theme_genius
[coverage_badge]: coverage_badge.svg
[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
