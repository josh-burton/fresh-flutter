import 'package:flutter/material.dart';
import 'package:fresh_flutter/feature/home/home_view_model.dart';
import 'package:fresh_flutter/feature/home/repository/home_repository.dart';
import 'package:keel/keel.dart';
import 'package:provider/provider.dart';

import '../../inject.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE = "/";

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(inject<HomeRepository>()),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ViewModelEventListener<HomeViewModel, HomeEvent>(
        onEvent: (event) {  },
        child: Consumer<HomeViewModel>(
          builder: (context, model, widget) {
            return Container(
              child: Center(
                child: Text(model.text),
              ),
            );
          },
        ),
      ),
    );
  }
}
