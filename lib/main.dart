import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:fresh_flutter/FreshApp.dart';

import 'inject.dart';

bool enableCrashlytics = kReleaseMode;

void main() async {
//  Crashlytics.instance.enableInDevMode = false;
  if (enableCrashlytics) {
//    FlutterError.onError = Crashlytics.instance.recordFlutterError;
//    Fimber.plantTree(CrashlyticsTree());
  } else {
    Fimber.plantTree(DebugTree(useColors: true));
  }

  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();

  if (enableCrashlytics) {
    await runZonedGuarded<Future<void>>(() async {
      runApp(FreshApp());
    }, (Object ex, StackTrace stack) => Fimber.e("Uncaught error", ex: ex, stacktrace: stack));
  } else {
    runApp(FreshApp());
  }
}
