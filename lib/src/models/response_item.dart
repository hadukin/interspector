typedef ResponseHeader = Map<String, List<String>>;

class ResponseItem {
  final int status;
  final int size;
  final DateTime time = DateTime.now();
  final dynamic data;
  final ResponseHeader? headers;

  ResponseItem({
    required this.data,
    required this.headers,
    required this.status,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'size': size,
        'time': time,
        'data': data,
        'headers': headers,
      };

  ResponseItem copyWith({
    dynamic data,
    ResponseHeader? headers,
    int? status,
    int? size,
  }) {
    return ResponseItem(
      data: data ?? this.data,
      headers: headers ?? this.headers,
      status: status ?? this.status,
      size: size ?? this.size,
    );
  }

  @override
  int get hashCode => data.hashCode ^ headers.hashCode ^ status.hashCode ^ size.hashCode ^ time.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseItem &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          size == other.size &&
          time == other.time &&
          data == other.data &&
          headers == other.headers;
}
