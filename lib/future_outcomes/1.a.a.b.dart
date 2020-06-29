import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class OneAAB extends StatefulWidget {
  @override
  _OneAABState createState() => _OneAABState();
}

class _OneAABState extends State<OneAAB> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 16);
  static String story;
  AnimationController controller;
  Animation<String> animation;
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

  Future<bool> getFlag() async {
    await Future.delayed(Duration(seconds: 16));
    return animation.isCompleted;
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
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'SpecialElite',
                                  color: Colors.white));
                        },
                      ),
                    ),
                  ),
                ),
                FutureBuilder<bool>(
                    future: getFlag(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 8.0, 30.0, 8.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.white)),
                                    color: Colors.transparent,
                                    onPressed: () {
                                      takeMeAhead(index);
                                    },
                                    child: Text(options[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.merriweather(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    })
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
