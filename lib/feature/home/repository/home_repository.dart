import 'package:fresh_flutter/core/preferences.dart';

abstract class HomeRepository {}

class HomeApiRepository extends HomeRepository {
  final Preferences _preferences;

  HomeApiRepository(this._preferences);
}
