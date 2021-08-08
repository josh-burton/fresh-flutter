import 'package:flutter/material.dart';
import 'package:fresh_flutter/feature/home/repository/home_repository.dart';
import 'package:keel/keel.dart';

class HomeViewModel extends ViewModel<HomeEvent> with ChangeNotifier {
  final HomeRepository homeRepository;

  String text = "My text";

  HomeViewModel(this.homeRepository);
}

class HomeEvent {}
