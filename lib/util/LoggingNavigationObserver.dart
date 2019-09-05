import 'package:flutter/material.dart';

class LoggingNavigationObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPop(Route route, Route previousRoute) {
    debugPrint("Navigation didPop: ${route?.settings?.name}");
  }

  @override
  void didPush(Route route, Route previousRoute) {
    debugPrint("Navigation didPush: ${route?.settings?.name}");
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    debugPrint("Navigation didRemove: previousRoute:${previousRoute?.settings?.name},  route: ${route?.settings?.name}");
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    debugPrint("Navigation didReplace: ${oldRoute?.settings?.name} with ${newRoute?.settings?.name}");
  }
}
