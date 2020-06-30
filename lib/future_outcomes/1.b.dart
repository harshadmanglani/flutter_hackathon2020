import 'package:flutter/material.dart';
import 'futurestory.dart';

class OneB extends StatefulWidget {
  @override
  _OneBState createState() => _OneBState();
}

class _OneBState extends State<OneB> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        "You go outside and lean against your car. You look up and close your eyes, smelling the oil fumes and the mechanical whirrs of your car. Soon you hear sirens and look to see red and blue flashing lights. You close your eyes once again, feeling rested.";
    options = ["Continue"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
        story: story,
        options: options,
        seconds: 5,
        takeMeAhead: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/wakeup');
          }
        });
  }
}
