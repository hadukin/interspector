import 'package:dio/dio.dart';
import 'package:interspector/src/item.dart';
import 'package:interspector/src/store.dart';

class Interspector {
  ApiInterceptors dioInterceptor() => ApiInterceptors();
}

class ApiInterceptors extends InterceptorsWrapper {
  late Store _store;
  ApiInterceptors() {
    _store = Store();
  }

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // handler.next(options);
    print('REQUEST ${options.hashCode}');
    final perform = HttpPerform(id: options.hashCode);

    final r = RequestItem();
    r.body = options.data;
    r.headers = options.headers;
    final updatePerform = perform.copyWith(request: r);

    _store.addHttpPerform(updatePerform);

    print('PERFORM/REQUEST: ${updatePerform.toString()}');

    // do something before request is sent
    super.onRequest(options, handler); //add this line
  }

  @override
  Future<dynamic> onError(DioError dioError, ErrorInterceptorHandler handler) async {
    // handler.next(dioError);

    //handler.next(dioError);
    print('ERROR');
    // do something to error
    super.onError(dioError, handler); //add this line
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final id = response.requestOptions.hashCode;

    final perform = _store.getHttpPerformById(id);

    final res = ResponseItem();
    res.body = response.data;
    res.status = res.status;
    res.time = res.time;

    final updatePerform = perform?.copyWith(response: res);

    print('PERFORM/RESPONSE: ${updatePerform.toString()}');

    // _store.setResponse(HttpPerform(id: options.hashCode));

    // print('RESPONSE ${response.requestOptions.hashCode}');
    // do something before response
    super.onResponse(response, handler); //add this line
  }
}
