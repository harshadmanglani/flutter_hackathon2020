import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class OneABA extends StatefulWidget {
  @override
  _OneABAState createState() => _OneABAState();
}

class _OneABAState extends State<OneABA> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 3500);
  static String story;
  AnimationController controller;
  Animation<String> animation;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        """Backup arrives along with Johnny. With substantial firepower on your side you could easily overpower the factions. As your team is getting ready, you see the captain go off to the side of the warehouse. You follow him and see him dealing with the Hyperion faction. You hear a bang and look around to see that Johnny has shot you. “ Why? Why would you do this? You took an oath to protect and serve the citizens”. “That’s exactly what we are doing. Sometimes to protect the law, you have to break it,” he replied. “I can still help you, if you decide to join our cause”. “There is a right way to protect the city,” you reply, “But it definitely isn’t like this.” You fall to your knees as you succumb to your wounds.
    """;
    options = ["Continue"];
    controller = AnimationController(vsync: this, duration: _duration);
    animation = TypewriterTween(end: story).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void reset() {
    if (controller.status == AnimationStatus.completed) {
      controller.forward().whenComplete(() {
        setState(() {});
      });
    } else {
      controller.forward();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // reset();
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Warning"),
                  content: Text(
                    "If you go back now, you'll lose your progress! :(",
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                        child: Text('Continue'),
                      ),
                    ),
                  ],
                ));
      },
      child: Container(
          decoration: futureDecoration,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Text('${animation.value}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'SpecialElite',
                                  color: Colors.white));
                        },
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.transparent,
                            onPressed: () {
                              takeMeAhead(index);
                            },
                            child: Text(options[index],
                                style: GoogleFonts.merriweather(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal))),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ))),
    );
  }

  void takeMeAhead(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/wakeup');
    }
  }
}

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end})
      : super(begin: begin, end: end);

  @override
  String lerp(double t) {
    var cutoff = (end.length * t).round();
    return end.substring(0, cutoff);
  }
}
