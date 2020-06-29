import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class OneAA extends StatefulWidget {
  @override
  _OneAAState createState() => _OneAAState();
}

class _OneAAState extends State<OneAA> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 3500);
  static String story;
  AnimationController controller;
  Animation<String> animation;
  List<String> options;

  @override
  void initState() {
    super.initState();
    story =
        "You bust in and shoot a laser that passes straight through three people. Hearing the shot, both factions become trigger happy and a bloody gunfight ensues. You take the occasional shot but let the factions kill each other. Smart, right? With their numbers dwindling, MaltA, the leader of the Children of the Vault, grabs the prototype and bolts to his car. As he drives off, you escape from the gunfight.";
    options = ["Chase after him", "Let him escape (for now)"];
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
      Navigator.pushReplacementNamed(context, '/1.a.a.a');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/1.a.a.b');
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
