import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/detail_screen.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/store.dart';

class InterceptorScreen extends StatefulWidget {
  const InterceptorScreen({super.key});

  @override
  State<InterceptorScreen> createState() => _InterceptorScreenState();
}

class _InterceptorScreenState extends State<InterceptorScreen> {
  late Stream<List<HttpPerform>> stream;

  @override
  void initState() {
    super.initState();
    stream = Store().stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HttpPerform>>(
      initialData: const [],
      stream: stream,
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return DetailScreen(
                  //         id: item.id,
                  //         stream: stream,
                  //       );
                  //     },
                  //   ),
                  // );
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
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${item.request?.uri?.path}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(height: 8),
                              Text('${item.request?.baseUrl}'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(Icons.close, color: Colors.red),
                            Icon(Icons.check, color: Colors.green),
                            if (item.isLoading)
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
      },
    );
  }
}
