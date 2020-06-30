import 'package:flutter/material.dart';
import 'package:time_machine/future_outcomes/futurestory.dart';

class FutureInit extends StatefulWidget {
  @override
  _FutureInitState createState() => _FutureInitState();
}

class _FutureInitState extends State<FutureInit> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story = """
    High rise buildings and ill ridden slums surround the city which once was flourishing and beautiful. After the nuclear war 150 years ago, the world had completely changed. There was no country, everything was under the jurisdiction of the UN. A new world order, completely controlled by the rich, robots, humanoids and droids everywhere, bridges turned into high rise shipping container storage for the poor.
A flying cop car hovered over the place, with a deafening siren and you wake up, wincing in pain with a red hazy eyesight. Turns out, you are getting a call on your eyepiece. You see a shuttle crowded with slack-eyed teens high on household chemicals, and middle-aged housewives running errands to sustain their dissolving households.

As your eyes regain focus, you straighten up and pick up the call. It’s your partner, Johnny. “How bad is it?”. “Barely a scratch”, you sarcastically reply, while looking at the bullet lodged in your thigh. “I’ve got the coordinates of the next drop, sending it to you now”, you inform him while transmitting the information, “I’ll meet you there”. “No way I’m letting you leave. Wait for the Trauma Team to arrive”.

    """;
    options = ["Go to drop", "Stay and wait for the medical team"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
      story: story,
      options: options,
      seconds: 18,
      takeMeAhead: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/1.a');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/1.b');
        }
      },
    );
  }
}
