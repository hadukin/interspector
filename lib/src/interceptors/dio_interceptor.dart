import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:interspector/src/models/error_item.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';
import 'package:interspector/src/store.dart';

class Interspector {
  late Store _store;

  Interspector() {
    _store = Store.instance;
  }

  ApiInterceptors dioInterceptor() => ApiInterceptors(_store);
}

class ApiInterceptors extends InterceptorsWrapper {
  final Store _store;

  ApiInterceptors(this._store);

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requestItem = RequestItem(
      baseUrl: '${options.uri.scheme}://${options.uri.host}',
      uri: options.uri,
      method: options.method,
      queryParameters: options.uri.queryParameters,
      headers: options.headers,
      data: options.data,
    );

    _store.addRequest(requestItem, options.hashCode);

    // do something before request is sent
    super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    final requestId = err.requestOptions.hashCode;

    final error = ErrorItem();
    error.error = err;
    error.stackTrace = error.stackTrace;

    _store.addError(error, requestId);

    final response = err.response;

    if (response != null) {
      final responseItem = ResponseItem(
        data: response.data,
        headers: response.headers.map,
        size: utf8.encode(response.data.toString()).length,
        status: response.statusCode ?? 0,
      );

      _store.addResponse(responseItem, requestId);
    } else {
      final responseItem = ResponseItem(status: -1, data: null, headers: null, size: 0);
      _store.addResponse(responseItem, requestId);
    }

    return super.onError(err, handler);
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final id = response.requestOptions.hashCode;
    final responseItem = ResponseItem(
      data: response.data,
      headers: response.headers.map,
      size: utf8.encode(response.data.toString()).length,
      status: response.statusCode ?? 0,
    );

    _store.addResponse(responseItem, id);

    // do something before response
    super.onResponse(response, handler);
  }
}
