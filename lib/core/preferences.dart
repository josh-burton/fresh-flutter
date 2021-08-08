import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

abstract class Preferences {
  Preference<bool> get isFirstRun;
}

class AppPreferences extends Preferences {
  static const _kPrefIsFirstRun = "isFirstRun";

  final StreamingSharedPreferences _prefs;

  AppPreferences(this._prefs);

  @override
  Preference<bool> get isFirstRun => _prefs.getBool(_kPrefIsFirstRun, defaultValue: true);
}
