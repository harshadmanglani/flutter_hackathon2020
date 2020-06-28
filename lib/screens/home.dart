import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> _animation, _leftAnimation, _rightAnimation;
  AnimationController _controller, _left, _right;
  CurvedAnimation _curve, _leftCurve, _rightCurve;
  double x = 0.0, y = 0.0;
  int _animationValue = 0;

  @override
  void initState() {
    super.initState();
    normalAnimation();
    pastAnimation();
    futureAnimation();
  }

  normalAnimation() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _curve = CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.ease));

    _animation = Tween(begin: -50.0, end: -150.0).animate(_curve);

    _controller.addListener(() {
      setState(() {
        x = 0.0;
        y = _animation.value;
      });
    });
    _controller.repeat(reverse: true);
  }

  pastAnimation() {
    _left = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));

    _leftCurve = CurvedAnimation(
        parent: _left, curve: Interval(0.0, 1.0, curve: Curves.ease));

    _leftAnimation = Tween(begin: 0.0, end: -350.0).animate(_leftCurve);
    _left.addListener(() {
      setState(() {
        y = 0.0;
        x = _leftAnimation.value;
      });
    });
  }

  futureAnimation() {
    _right = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));

    _rightCurve = CurvedAnimation(
        parent: _right, curve: Interval(0.0, 1.0, curve: Curves.ease));

    _rightAnimation = Tween(begin: 0.0, end: 350.0).animate(_rightCurve);
    _right.addListener(() {
      setState(() {
        y = 0.0;
        x = _rightAnimation.value;
      });
    });
  }

  dynamic buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homeback2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              // SizedBox(height: 40.0),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: Text("Time Machine",
                          style: GoogleFonts.orbitron(
                              textStyle: TextStyle(
                                  fontSize: 30.0, color: Colors.white)))),
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.transparent,
                  shape: buttonShape,
                  onPressed: () {
                    playPastAnimation();
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        Navigator.pushNamed(context, '/wormhole');
                      });
                    });
                    Future.delayed(const Duration(seconds: 6), () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, '/past');
                        resetAnimation();
                      });
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(36.0, 8.0, 36.0, 8.0),
                    child: Text("Past",
                        style: GoogleFonts.cinzel(
                            textStyle: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  )),
              SizedBox(height: 30.0),
              RaisedButton(
                  color: Colors.transparent,
                  shape: buttonShape,
                  onPressed: () {
                    playFutureAnimation();
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        Navigator.pushNamed(context, '/wormhole');
                      });
                    });
                    Future.delayed(const Duration(seconds: 6), () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, '/future');
                        resetAnimation();
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
              SizedBox(height: 170),
              hoppingTimeMachine(
                imagePath: 'assets/time_machine.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hoppingTimeMachine({String imagePath}) {
    return AnimatedBuilder(
        animation: _animationValue == 0
            ? _animation
            : _animationValue == 1 ? _leftAnimation : _rightAnimation,
        builder: (context, snapshot) {
          return Transform.translate(
              offset: Offset(x, y),
              child: Image.asset(imagePath, width: 250, height: 230));
        });
  }

  playPastAnimation() {
    setState(() {
      _controller.stop();
      _right.stop();
      _animationValue = 1;
      _left.forward();
    });
  }

  playFutureAnimation() {
    setState(() {
      _controller.stop();
      _left.stop();
      _animationValue = 2;
      _right.forward();
    });
  }

  resetAnimation() {
    setState(() {
      _left.stop();
      _right.stop();
      _animationValue = 0;
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _left.dispose();
    _right.dispose();
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
