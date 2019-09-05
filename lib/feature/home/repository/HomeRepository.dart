import 'package:fresh_flutter/api/FreshApi.dart';
import 'package:fresh_flutter/core/Preferences.dart';

abstract class HomeRepository {}

class HomeApiRepository extends HomeRepository {
  final FreshApi _api;
  final Preferences _preferences;

  HomeApiRepository(this._api, this._preferences);
}
