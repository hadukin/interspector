import 'dart:async';

import 'package:interspector/src/item.dart';

class Store {
  Store._privateConstructor();

  static final Store instance = Store._privateConstructor();

  final List<HttpPerform> _data = [];

  final _inputController = StreamController<HttpPerform>();
  final _outputController = StreamController<List<HttpPerform>>.broadcast();

  Sink<HttpPerform> get _sink => instance._inputController.sink;
  Stream<List<HttpPerform>> get stream => instance._outputController.stream;

  Store() {
    instance._inputController.stream.listen(_listener);
    instance._outputController.add([]);
  }

  addHttpPerform(HttpPerform value) => _sink.add(value);

  addRequest(HttpPerform value) => _sink.add(value);

  addResponse(HttpPerform newHttpPerform) {
    _sink.add(newHttpPerform);
  }

  List<HttpPerform> get data => _data;

  HttpPerform? getHttpPerformById(int id) {
    return _data.firstWhere((element) => element.id == id);
  }

  void _listener(HttpPerform value) async {
    if (_data.isEmpty) {
      instance._outputController.add(_data..add(value));
    } else {
      final result = _data.map((e) {
        if (e.id == value.id) {
          return e..addResponse(value.response);
        } else {
          return e;
        }
      }).toList();

      instance._outputController.add(result);
    }
  }

  void close() {
    instance._inputController.close();
    instance._outputController.close();
  }
}
