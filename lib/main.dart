import 'package:flutter/material.dart';
import 'package:my_little_poney/widgets/horse_dialog.dart';
import 'package:my_little_poney/widgets/horses_page.dart';
import 'package:my_little_poney/widgets/profile_page.dart';

import 'models/Horse.dart';
import 'package:my_little_poney/api/user_service_io.dart';
import 'package:my_little_poney/usecase/user_usecase.dart';
import 'package:my_little_poney/widets/navigation.dart';
import 'package:my_little_poney/widets/test.dart';

import 'models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Little Poney',
      routes: {
        // put routes here
        Test.routeName: (context) => Test(),
        HorsesPage.routeName: (context) => HorsesPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigation(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
