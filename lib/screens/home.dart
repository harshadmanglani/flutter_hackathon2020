import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:time_machine/screens/retro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white));
  double currentValue = 21.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
            child: Text("Time Machine",
                style: GoogleFonts.orbitron(
                    textStyle: TextStyle(fontSize: 30.0)))),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                    "Feel like meeting Steve Jobs or visiting a Mars colony?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue,
                  shape: buttonShape,
                  onPressed: () {
                    Navigator.pushNamed(context, '/wormhole');
                    Future.delayed(const Duration(seconds: 4), () {
                      setState(() {
                    currentValue = 20.0;
                    Navigator.pushReplacementNamed(context, '/past');
                    });
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 3.0, 25.0, 3.0),
                    child: Text("Past",
                        style: GoogleFonts.ibmPlexMono(
                            textStyle: TextStyle(fontSize: 30.0))),
                  )),
              SizedBox(height: 30.0),
              RaisedButton(
                  color: Colors.red,
                  shape: buttonShape,
                  onPressed: () {
                    Navigator.pushNamed(context, '/wormhole');
                    Future.delayed(const Duration(seconds: 4), () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, '/future');
                      });
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text("Future",
                        style: GoogleFonts.cinzel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold))),
                  )),
              SizedBox(height: 100),
              HoppingTimeMachine(
                imagePath: 'assets/time_machine.jpg',
              ),
              // Slider(
              //   value: currentValue,
              //   activeColor: Colors.white,
              //   inactiveColor: Colors.white,
              //   min: 20,
              //   max: 22,
              //   divisions: 2,
              //   onChanged: (val) => setState(() {
              //     currentValue = val;
              //     print(val);
              //     if (currentValue == 20) {
              //       Future.delayed(const Duration(seconds: 1), () {
              //         setState(() {
              //           currentValue = 20.0;
              //           Navigator.pushNamed(context, '/past');
              //         });
              //       });
              //     } else if (currentValue == 22) {
              //       Future.delayed(const Duration(seconds: 1), () {
              //         setState(() {
              //           currentValue = 20.0;
              //           Navigator.pushNamed(context, '/future');
              //         });
              //       });
              //     } else {}
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class HoppingTimeMachine extends StatefulWidget {
  final String imagePath;

  HoppingTimeMachine({this.imagePath});

  @override
  _HoppingTimeMachineState createState() => _HoppingTimeMachineState();
}

class _HoppingTimeMachineState extends State<HoppingTimeMachine>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  CurvedAnimation _curve;
  double y = 0.0;

  String imagePath;

  @override
  void initState() {
    super.initState();
    imagePath = widget.imagePath;

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _curve = CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.ease));

    _animation = Tween(begin: -50.0, end: -100.0).animate(_curve);

    _controller.addListener(() {
      setState(() {
        y = _animation.value;
      });
    });
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, snapshot) {
          return Transform.translate(
              offset: Offset(0, y),
              child: Image.asset('assets/time_machine.jpg',
                  width: 250, height: 200));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WormHole extends StatefulWidget {
  @override
  WormHoleState createState() => WormHoleState();
}

class WormHoleState extends State<WormHole> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/wormhole.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(1.0);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _controller.value.isPlaying) {
          return Container(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.0 / 2.0,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
