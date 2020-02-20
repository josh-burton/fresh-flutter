import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:fresh_flutter/core/AppTheme.dart';
import 'package:fresh_flutter/feature/home/HomeScreen.dart';
import 'package:fresh_flutter/util/LoggingNavigationObserver.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'feature/splash/SplashScreen.dart';
import 'inject.dart';

class FreshApp extends StatefulWidget {
  @override
  _FreshAppState createState() => _FreshAppState();
}

class _FreshAppState extends State<FreshApp> with WidgetsBindingObserver {
  var lifecycle = inject<Subject<AppLifecycleState>>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    lifecycle.add(state);

    debugPrint("didChangeAppLifecycleState: ${state.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
          title: 'Fresh App',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(),
          navigatorObservers: [
            LoggingNavigationObserver(),
//            FirebaseAnalyticsObserver(analytics: inject<FirebaseAnalytics>()),
          ],
          initialRoute: SplashScreen.ROUTE,
          routes: <String, WidgetBuilder>{
            SplashScreen.ROUTE: (context) => SplashScreen(),
          },
          onGenerateRoute: (RouteSettings routeSettings) {
            Fimber.d("onGenerateRoute: ${routeSettings.name}");

            switch (routeSettings.name) {
              case HomeScreen.ROUTE:
                return _fadeRoute(
                  HomeScreen.ROUTE,
                  HomeScreen.create(),
                );
            }
            return null;
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  PageRouteBuilder _fadeRoute(String name, Widget widget, {Object arguments}) {
    return PageRouteBuilder<dynamic>(
        settings: RouteSettings(name: name, arguments: arguments),
        pageBuilder: (BuildContext context, _, __) {
          return widget;
        },
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        });
  }
}
