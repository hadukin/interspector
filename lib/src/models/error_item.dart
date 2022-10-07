class ErrorItem {
  dynamic error;
  StackTrace? stackTrace;

  Map<String, dynamic> toJson() => {
        'error': error,
        'stackTrace': stackTrace,
      };

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorItem && runtimeType == other.runtimeType && error == other.error && stackTrace == other.stackTrace;
}
