import 'package:flutter/material.dart';
import 'package:my_little_poney/widgets/contest_view.dart';
import 'package:my_little_poney/widgets/horses_page.dart';
import 'package:my_little_poney/widgets/lesson_view.dart';
import 'package:my_little_poney/widgets/list_event.dart';
import 'package:my_little_poney/widgets/reset-password.dart';
import 'widgets/lesson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Little Poney',
      routes: {
        // put routes here
        ContestView.tag: (context) => const ContestView(),
        LessonView.tag: (context) => const LessonView(),
        HorsesPage.routeName: (context) => HorsesPage(),
        ListEvents.routeName: (context) => const ListEvents(),
        ResetScreen.routeName: (context) => const ResetScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LessonListView(title: 'Lessons'),
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
