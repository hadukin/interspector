import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interspector/src/item.dart';
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
      // initialData: [],
      stream: Store.instance.stream,
      builder: (context, snapshot) {
        return Container(
          child: Text('${snapshot.data}'),
        );
      },
    );
  }
}
