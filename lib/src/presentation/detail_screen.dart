import 'package:flutter/material.dart';
import 'package:interspector/src/models/http_perform.dart';
import 'package:interspector/src/store.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.stream});
  final int id;
  final Stream<List<HttpPerform>> stream;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Stream<List<HttpPerform>> stream;

  @override
  void initState() {
    super.initState();
    stream = Store().stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.id}')),
      body: StreamBuilder<List<HttpPerform>>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Text('${snapshot.data}'),
            ],
          );
        },
      ),
    );
  }
}
