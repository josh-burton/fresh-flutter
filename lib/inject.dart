import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:flutter/material.dart';
import 'package:fresh_flutter/feature/home/repository/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:system_proxy/system_proxy.dart';

import 'core/preferences.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  final streamingPrefs = await StreamingSharedPreferences.instance;
  Map<String, String>? proxy = await SystemProxy.getProxySettings();

  inject.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());

  inject.registerSingleton<Subject<AppLifecycleState>>(BehaviorSubject.seeded(AppLifecycleState.resumed));

  inject.registerLazySingleton<Stream<AppLifecycleState>>(() {
    return inject<Subject<AppLifecycleState>>().debounceTime(Duration(milliseconds: 100));
  });

  inject.registerSingleton<StreamingSharedPreferences>(streamingPrefs);

  inject.registerLazySingleton<Preferences>(() {
    return AppPreferences(inject<StreamingSharedPreferences>());
  });

  inject.registerLazySingleton<Dio>(() {
    var options = BaseOptions();
    final dio = Dio(options);

    dio.transformer = FlutterTransformer();

    dio.interceptors.add(LogInterceptor());

    return dio;
  });

  inject.registerLazySingleton<HomeRepository>(() {
    return HomeApiRepository(inject<Preferences>());
  });

  return inject.allReady();
}
