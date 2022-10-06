import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:interspector/interspector.dart';

final client = Dio()..interceptors.add(Interspector().dioInterceptor());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    client.post('https://6212347701ccdac07434b998.mockapi.io/content');
    // client.get(
    //   'https://jsonplaceholder.typicode.com/todos?type=some-type&weight=10',
    //   queryParameters: {
    //     'name': 'anatoly',
    //     'age': 30,
    //   },
    //   // data: {
    //   //   'a': '111',
    //   //   'b': '222',
    //   //   'c': '333',
    //   // },
    // );
  }

  _get() {
    client.get(
      'https://jsonplaceholder.typicode.com/todos?type=some-type&weight=10',
      queryParameters: {
        'name': 'anatoly',
        'age': 30,
      },
      // data: {
      //   'a': '111',
      //   'b': '222',
      //   'c': '333',
      // },
    );
  }

  _post() {
    client.post('https://6212347701ccdac07434b998.mockapi.io/content');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: InterceptorScreen(),
          // ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _get,
                child: Text('GET'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _post,
                child: Text('POST'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return InterceptorScreen();
                    },
                  ));
                },
                child: Text('OPEN'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
