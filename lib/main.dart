import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/cyberpunkfuture.dart';
import 'screens/retro.dart';

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
      routes: {
        '/home': (BuildContext context) => Home(),
        '/wormhole': (BuildContext context) => WormHole(),
        '/past': (BuildContext context) => PastHome(),
        '/future': (BuildContext context) => FutureHome(),
        '/leaderboard': (BuildContext context) => LeaderBoard(),
        '/retrotech': (BuildContext context) => RetroTech(),
        '/retrocars': (BuildContext context) => RetroCars(),
      },
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(color: Colors.black54, brightness: Brightness.dark),
      ),
      home: Home(),
    );
  }
}
