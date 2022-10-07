import 'package:flutter/material.dart';
import 'package:interspector/src/models/error_item.dart';
import 'package:interspector/src/presentation/row_item.dart';

class ErrorTab extends StatelessWidget {
  const ErrorTab({
    super.key,
    this.item,
  });

  final ErrorItem? item;

  @override
  Widget build(BuildContext context) {
    // if (widget.isLoading) return const Center(child: CircularProgressIndicator());
    return Column(
      children: [
        RowItem(
          name: 'SIZE',
          value: '${item?.error}',
        ),
      ],
    );
  }
}
