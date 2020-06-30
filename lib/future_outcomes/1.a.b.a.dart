import 'package:flutter/material.dart';
import 'futurestory.dart';

class OneABA extends StatefulWidget {
  @override
  _OneABAState createState() => _OneABAState();
}

class _OneABAState extends State<OneABA> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        """Backup arrives along with Johnny. With substantial firepower on your side you could easily overpower the factions. As your team is getting ready, you see the captain go off to the side of the warehouse. You follow him and see him dealing with the Hyperion faction. You hear a bang and look around to see that Johnny has shot you. “ Why? Why would you do this? You took an oath to protect and serve the citizens”. “That’s exactly what we are doing. Sometimes to protect the law, you have to break it,” he replied. “I can still help you, if you decide to join our cause”. “There is a right way to protect the city,” you reply, “But it definitely isn’t like this.” You fall to your knees as you succumb to your wounds.
    """;
    options = ["Continue"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
        story: story,
        options: options,
        seconds: 8,
        takeMeAhead: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/wakeup');
          }
        });
  }
}
