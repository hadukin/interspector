import 'dart:io';

import 'package:flutter/material.dart';
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
      request: request ?? this.request,
      response: response ?? this.response,
    );
  }

  CallStatus get status {
    final _status = response?.status;
    if (_status != null) {
      bool isSuccess = _status >= 200 && _status <= 299;
      bool isRedirect = _status >= 300 && _status <= 399;
      bool isError = _status >= 400 && _status <= 499;

      if (isSuccess) {
        return CallStatus.succes;
      } else if (isRedirect) {
        return CallStatus.warning;
      } else if (isError) {
        return CallStatus.error;
      } else {
        return CallStatus.error;
      }
    } else {
      return CallStatus.pending;
    }
  }

  Color get statusColor {
    final _status = response?.status;

    if (_status != null) {
      bool isSuccess = _status >= 200 && _status <= 299;
      bool isRedirect = _status >= 300 && _status <= 399;
      bool isError = _status >= 400 && _status <= 499;

      if (isSuccess) {
        return Colors.green;
      } else if (isRedirect) {
        return Colors.yellow;
      } else if (isError) {
        return Colors.red;
      } else {
        return Colors.redAccent;
      }
    } else {
      return Colors.black;
    }
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

enum CallStatus {
  pending(Colors.black),
  succes(Colors.green),
  error(Colors.red),
  warning(Colors.yellow);

  final Color color;

  // final int statusCode;

  const CallStatus(this.color);
}
