import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/row_item.dart';
import 'package:interspector/src/store.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({
    super.key,
    required this.callId,
  });

  final int callId;

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<HttpCall>>(
        stream: Store.instance.callsSubject,
        builder: (context, snapshot) {
          HttpCall? httpCall = snapshot.data?.firstWhere((e) => e.id == widget.callId);
          if (httpCall?.request == null) return const CircularProgressIndicator();

          return Column(
            children: [
              RowItem(
                name: 'METHOD',
                value: httpCall?.request?.method,
              ),
              const Divider(),
              RowItem(
                name: 'BASE URL',
                value: httpCall?.request?.baseUrl,
              ),
              const Divider(),
              RowItem(
                name: 'PATH',
                value: '${httpCall?.request?.uri?.path}',
              ),
              const Divider(),
              RowItem(
                name: 'QUERY PARAMETERS',
                value: httpCall?.request?.queryParameters.toString(),
              ),
              const Divider(),
              RowItem(
                name: 'BODY',
                value: httpCall?.request?.body,
              ),
              const Divider(),
              RowItem(
                name: 'HEADERS',
                value: httpCall?.request?.headers.toString(),
              ),
              const Divider(),
              RowItem(
                name: 'TIME',
                value: httpCall?.request?.time.millisecond.toString(),
              ),
            ],
          );
        },
      ),
    );
  }
}
