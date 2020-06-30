import 'package:flutter/material.dart';
import 'futurestory.dart';

class OneAAB extends StatefulWidget {
  @override
  _OneAABState createState() => _OneAABState();
}

class _OneAABState extends State<OneAAB> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        """As he takes off, you take out your tracking gun and fire a tracker that flies and sticks to his car. You see the red blip of the tracker on the holographic map in your eyepiece.You request for backup from the Federation, giving them the tracker’s location. You overhear a conversation on the tracker between MaltA and the captain of the federation. You are shocked to hear that the federation is working with them. This was not what you signed up for. At the same time, Johnny arrives at the scene. “Lets go, I put a tracker on MaltA’s car,” you say while getting in Johnny’s car. “But you know what the Children of Vault are capable of. You can’t face them alone”, Johnny says. “Don’t worry, I’ve called for backup.” As you follow the red blip on the map that is Johnny, you contemplate your next step with this new information. As the blip comes closer, you arrive at an abandoned mall. Within seconds, backup also arrives at the scene. MaltA is standing in the middle of the parking lot, surrounded by all his people, armed to the teeth.
"This is it."
You look at the backup, taking notice of everyone surrounding the place. More than half of the corrupt federation is placed around the warehouse to take MaltA down. You cannot help but smile.

    """;
    options = ["Continue"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
        story: story,
        options: options,
        seconds: 16,
        takeMeAhead: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/wakeup');
          }
        });
  }
}
