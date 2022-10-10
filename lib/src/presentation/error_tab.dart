import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/row_item.dart';
import 'package:interspector/src/store.dart';

class ErrorTab extends StatelessWidget {
  const ErrorTab({
    super.key,
    required this.callId,
  });

  final int callId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<HttpCall>>(
        stream: Store.instance.callsSubject,
        builder: (context, snapshot) {
          HttpCall? httpCall = snapshot.data?.firstWhere((e) => e.id == callId);
          if (httpCall?.request == null) return const CircularProgressIndicator();

          return Column(
            children: [
              RowItem(
                name: 'STACK TRACE',
                value: '${httpCall?.error?.stackTrace}',
              ),
              const Divider(),
              RowItem(
                name: 'ERROR',
                value: '${httpCall?.error?.error}',
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
