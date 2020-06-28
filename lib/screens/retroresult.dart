import 'package:flutter/material.dart';

class RetroResult extends StatefulWidget {
  final int score;
  RetroResult({Key key, @required this.score}) : super(key: key);
  @override
  _RetroResultState createState() => _RetroResultState();
}

class _RetroResultState extends State<RetroResult> {
  int score;

  @override
  void initState() {
    super.initState();
    score = widget.score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REsult"),
      ),
      body: Column(
        children: <Widget>[
          Text("Your score is : $score"),
          SizedBox(height: 10.0),
          FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/past');
              },
              color: Colors.grey,
              child: Text("Continue"))
        ],
      ),
    );
  }
}
