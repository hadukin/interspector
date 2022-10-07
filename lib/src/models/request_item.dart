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

  @override
  int get hashCode =>
      uri.hashCode ^
      baseUrl.hashCode ^
      method.hashCode ^
      queryParameters.hashCode ^
      headers.hashCode ^
      data.hashCode ^
      time.hashCode ^
      body.hashCode ^
      contentType.hashCode ^
      cookies.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestItem &&
          runtimeType == other.runtimeType &&
          uri == other.uri &&
          baseUrl == other.baseUrl &&
          method == other.method &&
          queryParameters == other.queryParameters &&
          headers == other.headers &&
          data == other.data &&
          time == other.time &&
          body == other.body &&
          contentType == other.contentType &&
          cookies == other.cookies;
}
