import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:interspector/src/models/error_item.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/models/response_item.dart';
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

  addResponse(Response response, int? requestId) {
    if (requestId == null) return;

    HttpPerform? selectedCall = _selectCall(requestId);

    if (selectedCall == null) return;

    selectedCall.isLoading = false;
    selectedCall.response = ResponseItem(
      data: response.data,
      headers: response.headers.map,
      size: utf8.encode(response.data.toString()).length,
      status: response.statusCode ?? 0,
    );

    callsSubject.add([...callsSubject.value]);
  }

  addError(ErrorItem error, int? requestId) {
    final selectedCall = _selectCall(requestId);
    if (selectedCall == null) return;

    selectedCall.error = error;
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

  HttpPerform? _selectCall(int? requestId) =>
      callsSubject.value.firstWhere((call) => call.id == requestId, orElse: null);
}
