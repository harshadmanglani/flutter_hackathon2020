import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:time_machine/models/question_model.dart';
import 'dart:convert';
import 'package:time_machine/models/leaderboard_model.dart';

class ApiProvider {
  String baseUrl = "http://asynchack20.azurewebsites.net/graphql/";
  List<Question> questionList = [];
  List<dynamic> unparsedResponse = [];
  String responseFromApi;
  Map<dynamic, dynamic> parsedResponse;
  List<LeaderBoardEntry> leaderBoardList = [];

  Future<void> getAllQuestions(int id) async {
    questionList = [];
    try {
      Response response;
      if (id == 1)
        response = await post(baseUrl, body: {
          "query":
              '{ questionsModel(search:"Tech"){ question, options, answer, photolink} }'
        });
      else if (id == 2)
        response = await post(baseUrl, body: {
          "query":
              '{ questionsModel(search:"Cars"){ question, options, answer, photolink} }'
        });
      // print(response.body);
      // responseFromApi = json.encode(response.body);
      print(response.body);
      responseFromApi = response.body.replaceAll(r'\', '');
      responseFromApi = responseFromApi.replaceAll(r'ions":"{', 'ions":{');
      responseFromApi = responseFromApi.replaceAll(r'}","ans', '},"ans');
      parsedResponse = json.decode(responseFromApi);
      // print(parsedResponse);
      unparsedResponse = parsedResponse["data"]["questionsModel"];
      for (int i = 0; i < unparsedResponse.length; i++) {
        questionList.add(Question(
            correctAnswer: unparsedResponse[i]["answer"],
            question: unparsedResponse[i]["question"],
            options: {
              "a": unparsedResponse[i]["options"]["a"],
              "b": unparsedResponse[i]["options"]["b"],
              "c": unparsedResponse[i]["options"]["c"],
              "d": unparsedResponse[i]["options"]["d"]
            },
            photoUrl: unparsedResponse[i]["photolink"]));
      }

      return questionList;
    } catch (error) {
      print("error: $error");
    }
  }

  Future<Map<dynamic, dynamic>> sendDataToLeaderBoard(
      String username, int score, String category) async {
    try {
      Response response = await post(baseUrl, body: {
        "query":
            'mutation{ createLeader(username:"$username", scorestr:"$score", category:"$category"){ id, score, username, category} }'
      });
      print(response.body);
      responseFromApi = response.body.replaceAll(r'\', '');
      parsedResponse = json.decode(responseFromApi);
      return parsedResponse;
    } catch (error) {
      print("error: $error");
    }
  }

  Future<void> getDataFromLeaderBoard() async {
    leaderBoardList = [];
    try {
      Response response;
      response = await post(baseUrl,
          body: {"query": '{ leaderboardModel{ username, score, category} }'});
      // print(response.body);
      // responseFromApi = json.encode(response.body);
      // print(response.body);
      responseFromApi = response.body.replaceAll(r'\', '');
      parsedResponse = json.decode(responseFromApi);
      // print(parsedResponse);
      unparsedResponse = parsedResponse["data"]["leaderboardModel"];
      for (int i = 0; i < unparsedResponse.length; i++) {
        print(unparsedResponse[i]);
        leaderBoardList.add(LeaderBoardEntry(
            userName: unparsedResponse[i]["username"],
            score: unparsedResponse[i]["score"],
            category: unparsedResponse[i]["category"]));
      }
      return leaderBoardList;
    } catch (error) {
      print("error: $error");
    }
  }
}
