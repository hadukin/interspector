import 'dart:io';

class RequestItem {
  final Uri? uri;
  final String? baseUrl;
  final String method;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic> headers;
  final dynamic data;
  DateTime time = DateTime.now();
  dynamic body = "";
  String? contentType = "";
  List<Cookie> cookies = [];

  RequestItem({
    required this.uri,
    required this.baseUrl,
    required this.method,
    required this.queryParameters,
    required this.headers,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'uri': uri,
        'baseUrl': baseUrl,
        'method': method,
        'queryParameters': queryParameters,
        'headers': headers,
        'data': data,
        'time': time,
        'body': body,
        'contentType': contentType,
        'cookies': cookies,
      };

  @override
  String toString() => 'time: $time | queryParameters: $queryParameters';
}
