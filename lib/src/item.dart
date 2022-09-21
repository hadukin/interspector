import 'dart:io';

class RequestItem {
  DateTime time = DateTime.now();
  Map<String, dynamic> headers = {};
  dynamic body = "";
  String? contentType = "";
  List<Cookie> cookies = [];
  Map<String, dynamic> queryParameters = {};

  @override
  String toString() => 'time: $time | queryParameters: $queryParameters';
}

class ResponseItem {
  int status = 0;
  int size = 0;
  DateTime time = DateTime.now();
  dynamic body;
  Map<String, String>? headers;

  @override
  String toString() => 'time: $time | status: $status';
}

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

  addResponse(ResponseItem value) {
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

  @override
  String toString() {
    return '''
      id: $id,
      request: ${request.toString()},
      response: ${response.toString()},
    ''';
  }
}
