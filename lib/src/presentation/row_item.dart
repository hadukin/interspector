import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.name,
    this.value,
  });

  final String name;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(name),
          ),
          Expanded(
            flex: 3,
            child: Text('$value'),
          ),
        ],
      ),
    );
  }
}
