import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/row_item.dart';
import 'package:interspector/src/store.dart';
import 'package:interspector/src/utils/call_status_extension.dart';

class ResponseTab extends StatefulWidget {
  const ResponseTab({
    super.key,
    required this.callId,
  });

  final int callId;

  @override
  State<ResponseTab> createState() => _ResponseTabState();
}

class _ResponseTabState extends State<ResponseTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<List<HttpCall>>(
        stream: Store.instance.callsSubject,
        builder: (context, snapshot) {
          HttpCall? call = snapshot.data?.firstWhere((e) => e.id == widget.callId);
          if (call?.response == null) return const CircularProgressIndicator();

          return Column(
            children: [
              RowItem(
                name: 'SIZE',
                value: '${call?.response?.size}',
              ),
              const Divider(),
              RowItem(
                name: 'STATUS',
                value: '${call?.response?.status}',
                style: TextStyle(color: call?.response?.status.getCallStatusFromCode.color),
              ),
              const Divider(),
              RowItem(
                name: 'DATA',
                value: '${call?.response?.data}',
              ),
            ],
          );
        },
      ),
    );
  }
}
