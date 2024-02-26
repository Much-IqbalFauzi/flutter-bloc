import 'dart:async';

import 'package:bloc_vanilla/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  //state management
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _iCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  //event management
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _iCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
