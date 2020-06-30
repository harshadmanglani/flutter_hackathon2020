import 'package:flutter/material.dart';
import 'package:time_machine/future_outcomes/futurestory.dart';

class OneAA extends StatefulWidget {
  @override
  _OneAAState createState() => _OneAAState();
}

class _OneAAState extends State<OneAA> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        "You bust in and shoot a laser that passes straight through three people. Hearing the shot, both factions become trigger happy and a bloody gunfight ensues. You take the occasional shot but let the factions kill each other. Smart, right? With their numbers dwindling, MaltA, the leader of the Children of the Vault, grabs the prototype and bolts to his car. As he drives off, you escape from the gunfight.";
    options = ["Chase after him", "Let him escape (for now)"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
      story: story,
      options: options,
      seconds: 5,
      takeMeAhead: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/1.a.a.a');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/1.a.a.b');
        }
      },
    );
  }
}
