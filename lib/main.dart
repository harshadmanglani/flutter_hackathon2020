import 'package:flutter/material.dart';
import 'package:time_machine/future_outcomes/1.a.a.a.dart';
import 'package:time_machine/future_outcomes/1.a.a.b.dart';
import 'package:time_machine/future_outcomes/1.a.a.dart';
import 'package:time_machine/future_outcomes/1.a.b.a.dart';
import 'package:time_machine/future_outcomes/1.a.b.dart';
import 'package:time_machine/future_outcomes/1.a.dart';
import 'package:time_machine/future_outcomes/1.b.dart';
import 'package:time_machine/future_outcomes/futureinit.dart';
import 'package:time_machine/future_outcomes/wakeup.dart';
import 'screens/home.dart';
import 'screens/cyberpunkfuture.dart';
import 'screens/retro.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      routes: {
        '/home': (BuildContext context) => Home(),
        '/wormhole': (BuildContext context) => WormHole(),
        '/past': (BuildContext context) => PastHome(),
        '/future': (BuildContext context) => FutureHome(),
        '/leaderboard': (BuildContext context) => LeaderBoard(),
        '/retrotech': (BuildContext context) => RetroTech(),
        '/retrocars': (BuildContext context) => RetroCars(),
        '/futureinit': (BuildContext context) => FutureInit(),
        '/1.a': (BuildContext context) => OneA(),
        '/1.b': (BuildContext context) => OneB(),
        '/1.a.a': (BuildContext context) => OneAA(),
        '/1.a.b': (BuildContext context) => OneAB(),
        '/1.a.a.a': (BuildContext context) => OneAAA(),
        '/1.a.a.b': (BuildContext context) => OneAAB(),
        '/1.a.b.a': (BuildContext context) => OneABA(),
        '/wakeup': (BuildContext context) => WakeUp()
      },
      home: Home(),
    );
  }
}
