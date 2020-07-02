import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var futureDecoration = BoxDecoration(
    image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.42), BlendMode.dstATop),
        image: AssetImage("assets/futureback.jpeg"),
        fit: BoxFit.cover));

class FutureHome extends StatefulWidget {
  @override
  _FutureHomeState createState() => _FutureHomeState();
}

class _FutureHomeState extends State<FutureHome>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _animation = Tween(
      begin: 1.0,
      end: 0.5,
    ).animate(_curve);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, '/wormhole');
          Future.delayed(const Duration(seconds: 4), () {
            setState(() {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          });
          return Future<bool>.value(false);
        },
        child: Scaffold(
          body: Container(
            decoration: futureDecoration,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text("The Future",
                      style: GoogleFonts.montserratSubrayada(
                          textStyle:
                              TextStyle(fontSize: 35.0, color: Colors.white))),
                  SizedBox(height: 250),
                  FadeTransition(
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/futureinit');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Begin the story!",
                              style: GoogleFonts.droidSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold))),
                        )),
                    opacity: _animation,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
