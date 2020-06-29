import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:time_machine/backend/apiprovider.dart';
import 'dart:async';
import 'package:time_machine/models/question_model.dart';
import 'package:time_machine/screens/retroresult.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questionList;
  int id;
  QuizPage(this.questionList, this.id);
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
  int timer = 60;
  String showtimer = '60';
  BuildContext originalContext;
  bool cancelTimer;
  int id;
  String url;

  Map<String, Color> btncolor;

  @override
  void initState() {
    super.initState();
    questionList = widget.questionList;
    print(questionList[0].photoUrl);
    id = widget.id;
    btncolor = {
      "a": colorToShow,
      "b": colorToShow,
      "c": colorToShow,
      "d": colorToShow
    };
    cancelTimer = false;
    startTimer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RetroResult(
                  score: score,
                  id: id,
                )));
      } else {
        i++;
        timer = 60;
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
    try {
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
          title: id == 1 ? "Tech Quiz" : "Cars Quiz",
          body: Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      questionList[i].question,
                      style: Flutter95.textStyle,
                    ),
                  ),
                ),
                // StreamBuilder<String>(
                // stream: _urlStream,
                // builder: (context, snapshot) {
                // print(snapshot.data);
                // if (snapshot.hasData) {
                // return
                questionList[i].photoUrl != null
                    ? Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    questionList[i].photoUrl),
                                fit: BoxFit.cover)))
                    : Container(
                        child: Text("No image to display",
                            style: Flutter95.textStyle),
                      ), //;
                // } else {
                // print("hi");
                // return Text("No image to display.");
                // }
                // }),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choiceButton(questionList[i].options['a'], 'a'),
                      choiceButton(questionList[i].options['b'], 'b'),
                      choiceButton(questionList[i].options['c'], 'c'),
                      choiceButton(questionList[i].options['d'], 'd'),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      showtimer,
                      style: Flutter95.textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (error) {
      setState(() {
        cancelTimer = true;
      });
      return Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/internet_error.png"),
                  fit: BoxFit.fitWidth)));
    }
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
