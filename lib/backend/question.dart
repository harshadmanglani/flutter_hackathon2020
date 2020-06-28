import 'package:flutter/material.dart';
import 'dart:async';
import 'package:time_machine/models/question_model.dart';
import 'package:time_machine/screens/retroresult.dart';

class QuizPage extends StatefulWidget {
  final List<Question> myquestion;
  QuizPage(this.myquestion);
  // var myquestion = Question();
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // var myquestion = Question();

  Color colortoshow = Colors.grey;
  Color rightanswer = Colors.green;
  Color wronganswer = Colors.red;
  int score = 0;
  int i = 0;
  int timer = 120;
  String showtimer = '120';

  Map<String, Color> btncolor = {
    "a": Colors.grey,
    "b": Colors.grey,
    "c": Colors.grey,
    "d": Colors.grey
  };

  @override
  void initState() {
    startTimer();
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
      btncolor['a'] = Colors.grey;
      btncolor['b'] = Colors.grey;
      btncolor['c'] = Colors.grey;
      btncolor['d'] = Colors.grey;
    });
  }

  void checkAnswer(String ans) {
    if (widget.myquestion[i].correctAnswer ==
        widget.myquestion[i].options[ans]) {
      score += 10;
      print(score);
      colortoshow = rightanswer;
    } else {
      colortoshow = wronganswer;
    }
    setState(() {
      btncolor[ans] = colortoshow;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String option, String key) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkAnswer(key),
        child: Text(
          option,
          style: TextStyle(color: Colors.teal),
          maxLines: 1,
        ),
        color: btncolor[key],
        minWidth: 160.0,
        height: 50.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                  title: Text("Time Quiz"),
                  content: Text("You cannot go back!!"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.myquestion[i].question,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )),
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
    );
  }
}
