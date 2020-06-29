import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_machine/screens/cyberpunkfuture.dart';

class OneA extends StatefulWidget {
  @override
  _OneAState createState() => _OneAState();
}

class _OneAState extends State<OneA> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 10);
  static String story;
  AnimationController controller;
  Animation<String> animation;
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
    await Future.delayed(Duration(seconds: 10));
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
      Navigator.pushReplacementNamed(context, '/1.a.a');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/1.a.b');
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
