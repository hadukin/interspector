import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/store.dart';

class InterceptorScreen extends StatefulWidget {
  const InterceptorScreen({super.key});

  @override
  State<InterceptorScreen> createState() => _InterceptorScreenState();
}

class _InterceptorScreenState extends State<InterceptorScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HttpPerform>>(
      initialData: const [],
      stream: Store.instance.stream,
      builder: (context, snapshot) {
        return ListView(
          children: [
            for (final item in snapshot.data ?? <HttpPerform>[])
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsView(perform: item);
                      },
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('URI: ${item.request?.baseUrl}'),
                      const Divider(),
                      Text('URI: ${item.request?.uri}'),
                      const Divider(),
                      Text('METHOD: ${item.request?.method}'),
                      const Divider(),
                      Text('ID: ${item.id}'),
                      const Divider(),
                      Text('QUERY: ${item.request?.queryParameters}'),
                      const Divider(),
                      Text('TIME: ${item.timeInMilliseconds}'),
                      const Divider(),
                      Text('REQUEST: ${item.request}'),
                      const Divider(),
                      Text('RESPONSE: ${item.response}'),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
