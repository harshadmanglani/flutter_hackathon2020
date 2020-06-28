import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:time_machine/backend/apiprovider.dart';
import 'dart:async';

class RetroResult extends StatefulWidget {
  final int score;
  final int id;
  RetroResult({Key key, @required this.score, this.id}) : super(key: key);
  @override
  _RetroResultState createState() => _RetroResultState();
}

class _RetroResultState extends State<RetroResult> {
  int score;
  TextEditingController _username;
  String username;
  int id;
  ApiProvider obj;
  Future<Map<dynamic, dynamic>> response;

  @override
  void initState() {
    super.initState();
    score = widget.score;
    id = widget.id;
    obj = ApiProvider();
    _username = TextEditingController();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Enter your username to be visible on the global leaderboard!",
                  style: Flutter95.textStyle),
            ),
            SizedBox(
              height: 20.0,
            ),
            response == null
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField95(
                          controller: _username,
                        ),
                      ),
                      Button95(
                        onTap: () {
                          String category;
                          if (id == 1)
                            category = "Tech";
                          else if (id == 2) category = "Cars";
                          print(category);
                          setState(() {
                            response = obj.sendDataToLeaderBoard(
                                _username.text, score, category);
                          });
                        },
                        child: Text(
                          "Update Leaderboard",
                          style: Flutter95.textStyle,
                        ),
                      )
                    ],
                  )
                : FutureBuilder<Map<dynamic, dynamic>>(
                    future: response,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.containsKey("data")) {
                          return Button95(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Continue",
                              style: Flutter95.textStyle,
                            ),
                          );
                        } else if (snapshot.data.containsKey("errors")) {
                          return Column(
                            children: <Widget>[
                              Text(
                                "Something went wrong, please email async@flutterhackathon.com",
                                style: Flutter95.textStyle,
                              ),
                              Button95(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Continue",
                                  style: Flutter95.textStyle,
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      } else {
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}
