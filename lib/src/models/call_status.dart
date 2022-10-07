import 'package:flutter/material.dart';

enum CallStatus {
  pending(Colors.black),
  succes(Colors.green),
  error(Colors.red),
  warning(Colors.yellow);

  final Color color;

  const CallStatus(this.color);
}
