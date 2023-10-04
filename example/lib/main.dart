import 'dart:developer';

import 'package:example/app/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(const App());
}
