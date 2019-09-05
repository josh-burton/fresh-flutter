import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

abstract class ReactiveListRepository<D> {

  final Subject<List<D>> _data = BehaviorSubject();

  Stream<List<D>> get data => _data.stream;

  Stream<int> get count => _data.map((data) => data.length);

  @protected
  Future<List<D>> fetch();

  Future<void> update() {
    return fetch()
        .then(_data.add)
        .catchError((Object error, StackTrace stack) {
      Fimber.e("Failed to update", ex: error, stacktrace: stack);
      _data.add(null);
    });
  }

}