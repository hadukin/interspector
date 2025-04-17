import 'package:flutter/material.dart';
import 'package:interspector/src/models/call_status.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/detail_view.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({
    super.key,
    required this.data,
  });

  final List<HttpCall>? data;

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final item in widget.data?.reversed ?? <HttpCall>[])
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return DetailsView(httpCall: item);
                  },
                ),
              );
            },
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.request?.method}: ',
                            // style: Theme.of(context).textTheme.bodyText2?.copyWith(color: item.status.color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${item.request?.uri?.path}',
                            // style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 8),
                          Text('${item.request?.baseUrl}'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${normalizeTime(item.request?.time.hour)}:${normalizeTime(item.request?.time.minute)}:${normalizeTime(item.request?.time.second)}',
                                ),
                              ),
                              Expanded(
                                child: Text('${item.timeInMilliseconds} ms'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        if (item.status == CallStatus.error) Icon(Icons.close, color: Colors.red),
                        if (item.status == CallStatus.succes) Icon(Icons.check, color: Colors.green),
                        if (item.status == CallStatus.pending)
                          SizedBox(
                            child: CircularProgressIndicator(strokeWidth: 2),
                            width: 24,
                            height: 24,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

String normalizeTime(int? time) {
  if (time == null) return '';

  if (time < 10) {
    return '0$time';
  } else {
    return '$time';
  }
}
