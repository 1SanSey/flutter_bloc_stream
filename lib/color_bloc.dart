import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { eventOrange, eventGrey }

class ColorBloc {
  Color _color = Colors.deepOrangeAccent;

  final _inputEventController =
      StreamController<ColorEvent>(); // Создали поток для событий
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream =>
      _outputStateController.stream; // Создали выходной поток для состояний

  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.eventOrange) {
      _color = Colors.deepOrangeAccent;
    } else if (event == ColorEvent.eventGrey) {
      _color = Colors.blueGrey;
    } else {
      throw Exception('Wrong Event Type');
    }
    _outputStateController.sink.add(_color);
  }

  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
