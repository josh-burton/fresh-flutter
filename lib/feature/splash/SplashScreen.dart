import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:fresh_flutter/feature/home/HomeScreen.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE = "splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {
  StreamSubscription subscription;
  double imageOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Splash"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      imageOpacity = 1.0;
    });

    subscription = TimerStream<bool>(true, Duration(seconds: 1)).listen((route) {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.ROUTE, (it) => it == null);
      }
    });
  }
}
