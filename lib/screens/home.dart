import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
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
              SizedBox(height: 30.0),
              RaisedButton(
                  color: Colors.blue,
                  shape: buttonShape,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Past",
                        style: GoogleFonts.galada(
                            textStyle: TextStyle(
                                color: Colors.white, fontSize: 20.0))),
                  )),
              SizedBox(height: 30.0),
              RaisedButton(
                  color: Colors.red,
                  shape: buttonShape,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Future",
                        style: GoogleFonts.cinzel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
