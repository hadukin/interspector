import 'package:flutter/material.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/presentation/row_item.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({super.key, required this.request});
  final RequestItem request;

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowItem(
          name: 'METHOD',
          value: widget.request.method,
        ),
        const Divider(),
        RowItem(
          name: 'BASE URL',
          value: widget.request.baseUrl,
        ),
        const Divider(),
        RowItem(
          name: 'PATH',
          value: '${widget.request.uri?.path}',
        ),
        const Divider(),
        RowItem(
          name: 'QUERY PARAMETERS',
          value: widget.request.queryParameters.toString(),
        ),
        const Divider(),
        RowItem(
          name: 'BODY',
          value: widget.request.body,
        ),
        const Divider(),
        RowItem(
          name: 'HEADERS',
          value: widget.request.headers.toString(),
        ),
        const Divider(),
        RowItem(
          name: 'TIME',
          value: widget.request.time.millisecond.toString(),
        ),
      ],
    );
  }
}
