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
    questionList = [];
    try {
      Response response;
      if (id == 1)
        response = await post(baseUrl, body: {
          "query":
              '{ questionsModel(search:"Tech"){ question, options, answer} }'
        });
      else if (id == 2)
        response = await post(baseUrl, body: {
          "query":
              '{ questionsModel(search:"Cars"){ question, options, answer} }'
        });
      // print(response.body);
      // responseFromApi = json.encode(response.body);
      // print(response.body);
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

      return questionList;
    } catch (error) {
      print("error: $error");
    }
  }
}
