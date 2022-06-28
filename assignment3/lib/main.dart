import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment-3',
      theme: ThemeData(
        // Define the default brightness.
        brightness: Brightness.light,
      ),
      home: const MyHomePage(title: 'Assignment3-Simple UI'),
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
  int _number = 0;
  String _display = " ";

  void _incrementCounter() {
    setState(() {
      _display = "Incrementing";
      _number++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _display = "Decrementing";
      _number--;
    });
  }

  void _doubleCounter() {
    setState(() {
      _display = "Doubling";
      _number = _number * 2;
    });
  }

  void _halving() {
    setState(() {
      _display = "Halving";
      _number = _number ~/ 2;
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
              Text(
                "$_display",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              Text(
                '$_number',
                style: TextStyle(fontSize: 150),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Add 1',
                child: const Icon(Icons.plus_one),
              ),
              FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Minus 1',
                child: const Icon(Icons.exposure_minus_1),
              ),
              FloatingActionButton(
                onPressed: _doubleCounter,
                tooltip: 'Double',
                child: const Icon(Icons.star),
              ),
              FloatingActionButton(
                onPressed: _halving,
                tooltip: 'Half',
                child: const Icon(Icons.splitscreen),
              )
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
