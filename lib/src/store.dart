import 'dart:async';
import 'package:interspector/src/models/error_item.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';
import 'package:rxdart/rxdart.dart';

class Store {
  Store._() {
    _callsSubscription = callsSubject.listen(callsListener);
  }

  static final Store _instance = Store._();

  static Store get instance => _instance;

  void addRequest(RequestItem requestItem, int requestId) {
    final httpCall = HttpCall(id: requestId).copyWith(request: requestItem);

    callsSubject.add([...callsSubject.value, httpCall]);
  }

  void addResponse(ResponseItem response, int? requestId) {
    if (requestId == null) return;
    HttpCall? selectedCall = _selectCall(requestId);

    if (selectedCall == null) return;

    selectedCall.addResponse(response);

    callsSubject.add([...callsSubject.value]);
  }

  void addError(ErrorItem error, int? requestId) {
    final selectedCall = _selectCall(requestId);
    if (selectedCall == null) return;

    selectedCall.isLoading = false;
    selectedCall.error = error;

    selectedCall.addError(error);
    callsSubject.add([...callsSubject.value]);
  }

  void close() {
    callsSubject.close();
    _callsSubscription?.cancel();
  }

  final BehaviorSubject<List<HttpCall>> callsSubject = BehaviorSubject.seeded([]);

  StreamSubscription? _callsSubscription;

  void callsListener(List<HttpCall> event) {
    print(event);
  }

  void dispose() {
    callsSubject.close();
    _callsSubscription?.cancel();
  }

  HttpCall? _selectCall(int? requestId) => callsSubject.value.firstWhere((call) => call.id == requestId, orElse: null);
}
