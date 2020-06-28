import 'package:http/http.dart';
import 'package:time_machine/models/question_model.dart';
import 'dart:convert';

class ApiProvider {
  String baseUrl = "http://asynchack20.azurewebsites.net/graphql/";
  List<Question> questionList = [];
  List<dynamic> unparsedResponse = [];
  String responseFromApi;
  Map<dynamic, dynamic> parsedResponse;

  Future<void> getAllQuestions(int id) async {
    try {
      Response response = await post(baseUrl,
          body: {"query": "{ questionsModel{ question, options, answer} }"});
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
            }));
      }
    } catch (error) {
      print("error: $error");
    }
  }

  getTechQuestionList() {
    getAllQuestions(1);
    return questionList;
  }

  getCarQuestionList() async {
    await getAllQuestions(1);
    for (int i = 0; i < unparsedResponse.length; i++) {
      questionList.add(Question(
          correctAnswer: unparsedResponse[i]["answer"],
          question: unparsedResponse[i]["question"],
          options: unparsedResponse[i]["options"]));
    }
    return questionList;
  }
}
