import 'package:flutter/material.dart';
import 'futurestory.dart';

class OneAAA extends StatefulWidget {
  @override
  _OneAAAState createState() => _OneAAAState();
}

class _OneAAAState extends State<OneAAA> {
  static String story;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        """You get in your car and floor it and chase after him. He maniacally drives through traffic, darting through signals, one way roads, parks and driving over sidewalks.
You tailgate him through all the carnage and eventually he loses control and crashes into an abandoned mall. He kicks his door open and stumbles out. You get out of your car and charge your magnum. As you approach him, you see a smile crawl over his face instead of fear. You get an ominous thought and your fears are confirmed as you hear the cocking of shotguns, rifles, handguns and plasma rifles all around you. You look at him one more time before everything disappears.
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
