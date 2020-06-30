import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class FutureStory extends StatefulWidget {
  final int seconds;
  final String story;
  final List<String> options;
  final Function takeMeAhead;

  FutureStory({this.options, this.seconds, this.story, this.takeMeAhead});

  @override
  _FutureStoryState createState() => _FutureStoryState();
}

class _FutureStoryState extends State<FutureStory>
    with SingleTickerProviderStateMixin {
  static Duration _duration;
  static String story;
  AnimationController controller;
  Animation<String> animation;
  List<String> options;
  Function takeMeAhead;

  @override
  void initState() {
    super.initState();
    story = widget.story;
    options = widget.options;
    _duration = Duration(seconds: widget.seconds);
    controller = AnimationController(vsync: this, duration: _duration);
    animation = TypewriterTween(end: story).animate(controller);
    takeMeAhead = widget.takeMeAhead;
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> getFlag() async {
    await Future.delayed(_duration);
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
