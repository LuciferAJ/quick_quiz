import 'dart:convert';

import 'package:http/http.dart' as http;

class QuizAPIManager{

  static String scienceCategoryURL='https://opentdb.com/api.php?amount=10&category=17&type=multiple';
  static String sportsCategoryURL='https://opentdb.com/api.php?amount=10&category=21&type=multiple';
  static String mathsCategoryURL='https://opentdb.com/api.php?amount=10&category=19&type=multiple';
  static String computerCategoryURL='https://opentdb.com/api.php?amount=10&category=18&type=multiple';

  static Future<Map<String,dynamic>> getQuizData(String quizURL) async {
    return http
        .post(
      quizURL,
      headers: {'content-type': "application/json"},
      encoding: utf8,
    )
        .then((response) {
      if (response != null) {
        var convertedData = jsonDecode(utf8.decode(response.bodyBytes));
        if (convertedData['results'] != null) {
          return convertedData;
        }
        return null;
      }
      return null;
    });
  }
}