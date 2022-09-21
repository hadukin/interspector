import 'package:flutter/material.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/presentation/row_item.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({super.key, required this.request});
  final RequestItem request;

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowItem(
          name: 'method',
          value: widget.request.method,
        ),
        const Divider(),
        RowItem(
          name: 'baseUrl',
          value: widget.request.baseUrl,
        ),
        const Divider(),
        RowItem(
          name: 'queryParameters',
          value: widget.request.queryParameters.toString(),
        ),
        const Divider(),
        RowItem(
          name: 'body',
          value: widget.request.body,
        ),
        const Divider(),
        RowItem(
          name: 'headers',
          value: widget.request.headers.toString(),
        ),
        const Divider(),
        RowItem(
          name: 'time',
          value: widget.request.time.millisecond.toString(),
        ),
      ],
    );
  }
}
