import 'dart:convert';

import 'file:///C:/Users/ajay8/Desktop/quick_quiz/lib/screens/quiz/quiz.dart';

class QuizModel{
 final int response_code;
 final List<Results> results;

 QuizModel({this.response_code,this.results});

 factory QuizModel.fromResponse(Map data){
   print("908798723");
   print("Data+++++"+data.toString());
   data = data??{};
   return QuizModel(
     response_code: data['response_code']??0,
     results: List<Results>.from(data["results"].map((x) => Results.fromResponse(x))));

 }

}

class Results{
  final String category;
  // final String type;
  // final String difficulty;
  // final String question;
  // final String correctAns;
Results({this.category});

factory Results.fromResponse(Map data){
  data = data??{};
  return Results(category: data['category']);
}
}