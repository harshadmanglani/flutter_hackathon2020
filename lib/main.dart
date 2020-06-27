import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(TimeMachine());
}

class TimeMachine extends StatefulWidget {
  @override
  _TimeMachineState createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/home': (BuildContext context) => Home()},
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(color: Colors.black54, brightness: Brightness.dark),
      ),
      home: Home(),
    );
  }
}
