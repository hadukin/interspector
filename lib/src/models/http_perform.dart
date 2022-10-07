import 'package:flutter/material.dart';
import 'package:interspector/src/models/call_status.dart';
import 'package:interspector/src/models/error_item.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';
import '../utils/call_status_extension.dart';

class HttpCall {
  final int id;
  bool isLoading = false;
  RequestItem? request;
  ResponseItem? response;
  ErrorItem? error;

  HttpCall({
    required this.id,
    this.request,
    this.response,
    this.error,
  });

  addRequest(RequestItem value) {
    request = value;
    isLoading = true;
  }

  addResponse(ResponseItem? value) {
    response = value;
    isLoading = false;
  }

  addError(ErrorItem? value) {
    error = value;
    isLoading = false;
  }

  HttpCall copyWith({
    RequestItem? request,
    ResponseItem? response,
    ErrorItem? error,
  }) {
    return HttpCall(
      id: id,
      request: request ?? this.request,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }

  CallStatus get status {
    final status = response?.status;
    return status.getCallStatusFromCode;
  }

  Color get statusColor {
    final status = response?.status;
    return status.getCallStatusFromCode.color;
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
        'id': id,
        'request': request?.toJson(),
        'response': response?.toJson(),
        'error': error?.toJson(),
      };

  @override
  int get hashCode => id.hashCode ^ isLoading.hashCode ^ request.hashCode ^ response.hashCode ^ error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpCall && runtimeType == other.runtimeType && request == other.request && response == other.response;
}
