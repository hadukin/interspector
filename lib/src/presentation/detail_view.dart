import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/error_tab.dart';
import 'package:interspector/src/presentation/request_tab.dart';
import 'package:interspector/src/presentation/response_tab.dart';
import 'package:interspector/src/store.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    super.key,
    required this.httpCall,
  });

  final HttpCall httpCall;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: StreamBuilder<List<HttpCall>>(
            stream: Store.instance.callsSubject,
            initialData: [widget.httpCall],
            builder: (context, snapshot) {
              HttpCall? httpCall = snapshot.data?.firstWhere((e) => e.id == widget.httpCall.id);
              if (httpCall?.request == null) return const CircularProgressIndicator();

              return Scaffold(
                appBar: AppBar(
                  title: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: httpCall?.status.color),
                    child: Text('${httpCall?.request?.uri?.path}'),
                  ),
                  bottom: const TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Request',
                      ),
                      Tab(
                        text: 'Response',
                      ),
                      Tab(
                        text: 'Error',
                      ),
                      Tab(
                        text: 'more',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    RequestTab(callId: widget.httpCall.id),
                    ResponseTab(callId: widget.httpCall.id),
                    ErrorTab(callId: widget.httpCall.id),
                    RequestTab(callId: widget.httpCall.id),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
