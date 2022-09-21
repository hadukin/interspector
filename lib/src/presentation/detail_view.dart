import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/models/request_item.dart';
import 'package:interspector/src/presentation/request_widget.dart';
import 'package:interspector/src/presentation/response_widget.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    super.key,
    required this.perform,
  });

  final HttpPerform perform;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('${widget.perform.request?.baseUrl}'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Request',
                ),
                Tab(
                  text: 'Response',
                ),
                Tab(
                  text: 'more',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RequestWidget(request: widget.perform.request!),
              SingleChildScrollView(
                child: ResponseWidget(
                  response: widget.perform.response,
                  isLoading: widget.perform.isLoading,
                ),
              ),
              Center(
                child: Text("more"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
