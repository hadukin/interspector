import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/presentation/detail_view.dart';
import 'package:interspector/src/presentation/list_request.dart';
import 'package:interspector/src/store.dart';

class InterceptorScreen extends StatefulWidget {
  const InterceptorScreen({super.key});

  @override
  State<InterceptorScreen> createState() => _InterceptorScreenState();
}

class _InterceptorScreenState extends State<InterceptorScreen> {
  late Stream<List<HttpCall>> stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inspector')),
      body: StreamBuilder<List<HttpCall>>(
        initialData: const [],
        stream: Store().callsSubject,
        builder: (context, snapshot) {
          if (snapshot.data?.length == 0) return const Center(child: Text('NO DATA'));
          return ListRequest(data: snapshot.data);
        },
      ),
    );
  }
}
