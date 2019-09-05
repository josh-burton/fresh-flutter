import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'ViewModel.dart';

class ViewModelScreen<M, E> extends StatefulWidget {
  final Widget child;
  final Function(E) onEvent;

  const ViewModelScreen({Key key, @required this.child, @required this.onEvent})
      : super(key: key);

  @override
  _ViewModelScreenState createState() => _ViewModelScreenState<M, E>();
}

class _ViewModelScreenState<M, E> extends State<ViewModelScreen<M, E>> {

  StreamSubscription<E> eventSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
      var model = Provider.of<M>(context, listen: false) as ViewModel<E>;
      model.onResume();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _trySubscribe(context);
    return widget.child;
  }

  void _trySubscribe(BuildContext context) {
    if (eventSubscription == null) {
      var model = Provider.of<M>(context, listen: false) as ViewModel<E>;
      eventSubscription = model.events.listen((E event) {
        widget.onEvent(event);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    eventSubscription?.cancel();
  }

}
