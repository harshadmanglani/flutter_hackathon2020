import 'package:http/http.dart';
import 'package:time_machine/models/question_model.dart';
import 'dart:convert';

class ApiProvider {
  String baseUrl = "http://asynchack20.azurewebsites.net/graphql/";
  List<Question> questionList;
  String responseFromApi;
  Map<dynamic, dynamic> parsedResponse;

  Future<void> getAllQuestions() async {
    Response response = await post(baseUrl,
        body: {"query": "{ questionsModel { question, options, answer, } }"});
    // print(response.body);
    // responseFromApi = json.encode(response.body);
    responseFromApi = response.body.replaceAll(r'\', '');
    responseFromApi = json.encode(responseFromApi);
    parsedResponse = json.decode(responseFromApi);
    print(responseFromApi);
    // print(parsedResponse);
    // print(response.body.toString());
  }

  getParsedQuestionList() {
    getAllQuestions();
  }
}
