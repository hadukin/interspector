import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.name,
    this.value,
    this.style,
  });

  final String name;
  final String? value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.bodyText1?.merge(style),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
