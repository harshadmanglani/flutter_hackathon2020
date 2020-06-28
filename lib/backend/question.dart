import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:time_machine/backend/apiprovider.dart';
import 'dart:async';
import 'package:time_machine/models/question_model.dart';
import 'package:time_machine/screens/retroresult.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questionList;
  QuizPage(this.questionList);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color colorToShow = Colors.black;
  Color rightAnswer = Colors.green;
  Color wrongAnswer = Colors.red;
  List<Question> questionList;
  ApiProvider obj;
  int score = 0;
  int i = 0;
  int timer = 31;
  String showtimer = '10';
  BuildContext originalContext;
  bool cancelTimer;

  Map<String, Color> btncolor;

  @override
  void initState() {
    questionList = widget.questionList;
    btncolor = {
      "a": colorToShow,
      "b": colorToShow,
      "c": colorToShow,
      "d": colorToShow
    };
    cancelTimer = false;
    startTimer();
    super.initState();
  }

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer == 0) {
          t.cancel();
          dialogBox95(
              titleText: "Time ran out on you",
              contentText: "But don't worry, we won't ;)",
              onPressed: () => () {
                    Navigator.pop(context);
                    nextQuestion();
                  },
              context: originalContext);
        } else if (cancelTimer) {
          t.cancel();
        } else {
          timer -= 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    setState(() {
      if (i == questionList.length - 1) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => RetroResult(score: score)));
      } else {
        i++;
        timer = 31;
      }
      btncolor['a'] = colorToShow;
      btncolor['b'] = colorToShow;
      btncolor['c'] = colorToShow;
      btncolor['d'] = colorToShow;
    });
    startTimer();
  }

  void checkAnswer(String answerKey) {
    print(answerKey);
    setState(() {
      cancelTimer = true;
      if (questionList[i].correctAnswer == questionList[i].options[answerKey]) {
        score += 10;
        btncolor[answerKey] = rightAnswer;
        Future.delayed(const Duration(milliseconds: 250), () {
          dialogBox95(
              titleText: "Correct Answer! :)",
              contentText: "Head to the next question? ",
              context: originalContext,
              onPressed: () => () {
                    Navigator.pop(context);
                    nextQuestion();
                  });
        });
      } else {
        btncolor[answerKey] = wrongAnswer;
        btncolor[correctAnswerKey(
                questionList[i].correctAnswer, questionList[i].options)] =
            rightAnswer;
        Future.delayed(const Duration(milliseconds: 250), () {
          dialogBox95(
              titleText: "Wrong Answer :(",
              contentText:
                  "The correct answer is ${questionList[i].correctAnswer}",
              context: originalContext,
              onPressed: () => () {
                    Navigator.pop(context);
                    nextQuestion();
                  });
        });
      }
    });
  }

  Widget choiceButton(String option, String answerKey) {
    return Button95(
      onTap: () => checkAnswer(answerKey),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            option,
            style: TextStyle(color: btncolor[answerKey]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    originalContext = context;
    return WillPopScope(
      onWillPop: () {
        if (i != 0)
          dialogBox95(
              titleText: "Timed Quiz!",
              contentText: "You cannot go to the previous question :(",
              context: context,
              onPressed: () => () {
                    Navigator.pop(context);
                  });
        else
          Navigator.pop(context);
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
                    questionList[i].question,
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
                        choiceButton(questionList[i].options['a'], 'a'),
                        choiceButton(questionList[i].options['b'], 'b'),
                        choiceButton(questionList[i].options['c'], 'c'),
                        choiceButton(questionList[i].options['d'], 'd'),
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
                        style: Flutter95.textStyle,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  dialogBox95(
      {BuildContext context,
      String titleText,
      Function onPressed,
      String contentText}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(titleText, style: Flutter95.textStyle),
              content: Text(
                contentText,
                style: Flutter95.textStyle,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: onPressed(),
                  child: Elevation95(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                      child: Text('Continue', style: Flutter95.textStyle),
                    ),
                  ),
                )
              ],
            ));
  }

  correctAnswerKey(String correctAnswer, Map<String, String> options) {
    if (options["a"] == correctAnswer) {
      return "a";
    }
    if (options["b"] == correctAnswer) {
      return "b";
    }
    if (options["c"] == correctAnswer) {
      return "c";
    }
    if (options["d"] == correctAnswer) {
      return "d";
    }
  }
}
