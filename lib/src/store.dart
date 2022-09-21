import 'dart:async';
import 'package:interspector/src/models/http_perform.dart';

class Store {
  // static Store? _instance;
  // Store._();
  // static Store get instance => _instance ??= Store._();
  ///////////
  // Store._privateConstructor();
  // static final Store _instance = Store._privateConstructor();
  // static Store get instance => _instance;
  //////////

  static Store? _singleton;

  factory Store() {
    _singleton ??= Store._();
    return _singleton!;
  }

  /// Creates alice core instance
  Store._() {
    _inputController.stream.listen(_listener);
    _outputController.add([]);
  }

  final List<HttpPerform> _data = [];

  final _inputController = StreamController<HttpPerform>();
  final _outputController = StreamController<List<HttpPerform>>.broadcast();

  Sink<HttpPerform> get _sink => _inputController.sink;
  Stream<List<HttpPerform>> get stream => _outputController.stream;

  // Store() {
  //   instance._inputController.stream.listen(_listener);
  //   instance._outputController.add([]);
  // }

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
    final listId = _data.map((element) => element.id);
    final hasElement = listId.contains(value.id);

    if (!hasElement) {
      _outputController.add(_data..add(value));
    } else {
      final result = _data.map((item) {
        if (item.id == value.id) {
          return item..addResponse(value.response);
        } else {
          return item;
        }
      }).toList();

      _outputController.add(result);
    }
  }

  void close() {
    _inputController.close();
    _outputController.close();
  }
}
