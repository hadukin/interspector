import 'dart:async';

import 'package:interspector/src/item.dart';

class Store {
  Store._privateConstructor();

  static final Store instance = Store._privateConstructor();

  final List<HttpPerform> _data = [];

  final _inputController = StreamController<HttpPerform>();
  final _outputController = StreamController<List<HttpPerform>>.broadcast();

  Sink<HttpPerform> get sink => _inputController.sink;
  Stream<List<HttpPerform>> get stream => _outputController.stream;

  Store() {
    _inputController.stream.listen(_listener);
    _outputController.add([]);
  }

  addRequest(HttpPerform value) => sink.add(value);

  addHttpPerform(HttpPerform value) => sink.add(value);

  addResponse(HttpPerform value) {
    // print(value);
    // _outputController.add(event);
  }

  List<HttpPerform> get data => _data;

  HttpPerform? getHttpPerformById(int id) {
    return _data.firstWhere((element) => element.id == id);
  }

  void _listener(HttpPerform value) async {
    _outputController.add(_data..add(value));
  }

  void close() {
    _inputController.close();
    _outputController.close();
  }
}
