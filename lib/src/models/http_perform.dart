import 'dart:io';

import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';

class HttpPerform {
  final int id;
  bool isLoading = true;
  RequestItem? request;
  ResponseItem? response;

  HttpPerform({
    required this.id,
    this.request,
    this.response,
  });

  addRequest(RequestItem value) => request = value;

  addResponse(ResponseItem? value) {
    response = value;
    isLoading = false;
  }

  HttpPerform copyWith({
    RequestItem? request,
    ResponseItem? response,
  }) {
    return HttpPerform(
      id: id,
      request: this.request ?? request,
      response: this.response ?? response,
    );
  }

  int? get timeInMilliseconds {
    final requestTime = request?.time;
    final responseTime = response?.time;
    if (requestTime != null && responseTime != null) {
      return responseTime.difference(requestTime).inMilliseconds;
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'request': request?.toJson(),
        'response': response?.toJson(),
      };
}
