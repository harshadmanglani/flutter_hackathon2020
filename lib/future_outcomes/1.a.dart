import 'package:flutter/material.dart';
import 'package:time_machine/future_outcomes/futurestory.dart';

class OneA extends StatefulWidget {
  @override
  _OneAState createState() => _OneAState();
}

class _OneAState extends State<OneA> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story = """
    Limping, you reach your car. As you climb into your car, your blood stains the interiors. You put the coordinates into the GeoSatNav and wait, clutching your leg as your car glides through the city.
When the car stops, you peek out of the window and see a warehouse. You grab your spare laser magnum and head towards the warehouse. You see the trade going on between the Children of the Vault and the Hyperion factions, the most destructive factions in this hemisphere. You overhear their conversation and find out that they are trading a prototype of a military assassin drone which was lost in a recent raid by the Children of the Vault.
    """;
    options = [
      "Go in guns blazing",
      "Scope out the warehouse and collect intel"
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureStory(
      options: options,
      story: story,
      takeMeAhead: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/1.a.a');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/1.a.b');
        }
      },
      seconds: 10,
    );
  }
}
