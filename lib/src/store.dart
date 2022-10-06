import 'dart:async';
import 'package:interspector/src/models/http_perform.dart';
import 'package:rxdart/rxdart.dart';

class Store {
  static Store? _singleton;

  factory Store() {
    _singleton ??= Store._();
    return _singleton!;
  }

  Store._() {
    // _inputController.stream.listen(_listener);
    // _outputController.add([]);
  }

  addHttpPerform(HttpPerform value) {
    callsSubject.add([...callsSubject.value, value]);
  }

  addRequest(HttpPerform value) => callsSubject.value.add(value);

  addResponse(HttpPerform value) {
    HttpPerform? selectedCall = _selectCall(value.id);

    if (selectedCall == null) return;

    selectedCall.isLoading = false;
    selectedCall.response = value.response;

    callsSubject.add([...callsSubject.value]);
  }

  HttpPerform? getHttpPerformById(int requestId) {
    return callsSubject.value.firstWhere((call) => call.id == requestId, orElse: null);
  }

  void close() {
    callsSubject.close();
    _callsSubscription?.cancel();
  }

  final BehaviorSubject<List<HttpPerform>> callsSubject = BehaviorSubject.seeded([]);

  StreamSubscription? _callsSubscription;

  void dispose() {
    callsSubject.close();
    _callsSubscription?.cancel();
  }

  HttpPerform? _selectCall(int requestId) =>
      callsSubject.value.firstWhere((call) => call.id == requestId, orElse: null);
}
