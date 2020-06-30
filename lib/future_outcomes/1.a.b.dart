import 'package:flutter/material.dart';
import 'futurestory.dart';

class OneAB extends StatefulWidget {
  @override
  _OneABState createState() => _OneABState();
}

class _OneABState extends State<OneAB> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        "You scout the warehouse, make note of all the possible exits, tag all the criminals in the deal, track and disable some of the less secure guns. Having collected all possible intel, you:";
    options = ["Call for backup with intel", "Feel confident and go solo"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
        story: story,
        options: options,
        seconds: 5,
        takeMeAhead: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/1.a.b.a');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/1.a.a');
          }
        });
  }
}
