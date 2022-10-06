import 'package:flutter/material.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/models/response_item.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/presentation/row_item.dart';

class ResponseWidget extends StatefulWidget {
  const ResponseWidget({
    super.key,
    required this.response,
    required this.isLoading,
  });
  final ResponseItem? response;
  final bool isLoading;

  @override
  State<ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) return const Center(child: CircularProgressIndicator());
    return Column(
      children: [
        RowItem(
          name: 'SIZE',
          value: '${widget.response?.size}',
        ),
        const Divider(),
        RowItem(
          name: 'DATA',
          value: '${widget.response?.data}',
        ),
        const Divider(),
        RowItem(
          name: 'STATUS',
          value: '${widget.response?.status}',
        ),
      ],
    );
  }
}
