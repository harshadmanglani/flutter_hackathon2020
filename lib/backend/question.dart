import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:time_machine/backend/apiprovider.dart';
import 'dart:async';
import 'package:time_machine/models/question_model.dart';
import 'package:time_machine/screens/retroresult.dart';

class QuizPage extends StatefulWidget {
  final List<Question> myquestion;
  QuizPage(this.myquestion);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color colorToShow = Colors.black;
  Color rightAnswer = Colors.green;
  Color wrongAnswer = Colors.red;
  ApiProvider obj;
  int score = 0;
  int i = 0;
  int timer = 120;
  String showtimer = '120';

  Map<String, Color> btncolor;

  @override
  void initState() {
    btncolor = {
      "a": colorToShow,
      "b": colorToShow,
      "c": colorToShow,
      "d": colorToShow
    };
    // startTimer();
    super.initState();
  }

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RetroResult(score: score)));
        } else {
          timer -= 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    setState(() {
      if (i < 1) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => RetroResult(score: score)));
      }
      btncolor['a'] = colorToShow;
      btncolor['b'] = colorToShow;
      btncolor['c'] = colorToShow;
      btncolor['d'] = colorToShow;
    });
  }

  void checkAnswer(String ans) {
    if (widget.myquestion[i].correctAnswer ==
        widget.myquestion[i].options[ans]) {
      score += 10;
      print(score);
      colorToShow = rightAnswer;
    } else {
      colorToShow = wrongAnswer;
    }
    setState(() {
      btncolor[ans] = colorToShow;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String option, String key) {
    return Button95(
      onTap: () => checkAnswer(key),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            option,
            style: TextStyle(color: btncolor[key]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Timed Quiz"),
                  content: Text(
                    "You cannot go back! :(",
                    style: Flutter95.textStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Elevation95(
                          child: Text('Ok', style: Flutter95.textStyle)),
                    )
                  ],
                ));
      },
      child: Scaffold95(
        title: "Tech Quiz",
        body: Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.myquestion[i].question,
                    style: Flutter95.textStyle,
                  ),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        choiceButton(widget.myquestion[i].options['a'], 'a'),
                        choiceButton(widget.myquestion[i].options['b'], 'b'),
                        choiceButton(widget.myquestion[i].options['c'], 'c'),
                        choiceButton(widget.myquestion[i].options['d'], 'd'),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Text(
                        showtimer,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
