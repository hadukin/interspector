class ResponseItem {
  int status = 0;
  int size = 0;
  dynamic data;
  DateTime time = DateTime.now();
  Map<String, String>? headers;

  Map<String, dynamic> toJson() => {
        'status': status,
        'size': size,
        'time': time,
        'data': data,
        'headers': headers,
      };
}
