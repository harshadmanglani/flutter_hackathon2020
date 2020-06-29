import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class WakeUp extends StatefulWidget {
  @override
  _WakeUpState createState() => _WakeUpState();
}

class _WakeUpState extends State<WakeUp> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 3500);
  static String story;
  AnimationController controller;
  Animation<String> animation;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        "You open your eyes and see a clock, no, a countdown, with six hours remaining. Rubbing your eyes, you get up, stretch your arms and legs and go to your chair. The Flutter hackathon is in its final stretch and with work still remaining, you continue the coding.";
    options = ["Continue Hacking!"];
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
            scrollDirection: Axis.vertical,
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
      Navigator.pop(context);
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
