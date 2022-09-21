import 'package:dio/dio.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';
import 'package:interspector/src/store.dart';

class Interspector {
  late Store _store;

  Interspector() {
    _store = Store();
  }

  ApiInterceptors dioInterceptor() => ApiInterceptors(_store);
}

class ApiInterceptors extends InterceptorsWrapper {
  final Store _store;
  ApiInterceptors(this._store);
  // ApiInterceptors() {
  //   _store = Store();
  // }

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // handler.next(options);
    final baseUrl = '${options.uri.scheme}://${options.uri.host}';

    final perform = HttpPerform(id: options.hashCode);

    final updatePerform = perform.copyWith(
      request: RequestItem(
        baseUrl: baseUrl,
        uri: options.uri,
        method: options.method,
        queryParameters: options.uri.queryParameters,
        headers: options.headers,
        data: options.data,
      ),
    );

    _store.addHttpPerform(updatePerform);

    // print('PERFORM/REQUEST: ${updatePerform.toString()}');

    // do something before request is sent
    super.onRequest(options, handler); //add this line
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    // handler.next(dioError);

    //handler.next(dioError);
    print('ERROR');
    // do something to error
    super.onError(err, handler); //add this line
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final id = response.requestOptions.hashCode;

    final perform = _store.getHttpPerformById(id);

    final res = ResponseItem();

    res.data = response.data;
    res.status = response.statusCode ?? 0;

    final updatePerform = perform?.copyWith(response: res);

    if (updatePerform != null) {
      _store.addResponse(updatePerform);
    }

    // do something before response
    super.onResponse(response, handler); //add this line
  }
}
