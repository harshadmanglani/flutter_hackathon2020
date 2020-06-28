import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

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
    return Scaffold95(
      title: "Result",
      body: Expanded(
        child: Column(
          children: <Widget>[
            Text(
              "Your score is : $score",
              style: Flutter95.textStyle,
            ),
            SizedBox(height: 10.0),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.grey,
                child: Elevation95(
                    child: Text("Continue", style: Flutter95.textStyle)))
          ],
        ),
      ),
    );
  }
}

// enter your score in the leaderboard
