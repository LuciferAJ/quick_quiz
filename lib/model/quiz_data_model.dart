// To parse this JSON data, do
//
//     final quizDataModel = quizDataModelFromJson(jsonString);

import 'dart:convert';



class QuizDataModel {
  QuizDataModel({
    this.results,
  });

  List<Result> results;

  factory QuizDataModel.fromJson(Map<String, dynamic> json) {
    return QuizDataModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))));
  }

}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  Category category;
  Type type;
  Difficulty difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: categoryValues.map[json["category"]],
        type: typeValues.map[json["type"]],
        difficulty: difficultyValues.map[json["difficulty"]],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );


}

enum Category { SCIENCE_COMPUTERS }

final categoryValues =
    EnumValues({"Science: Computers": Category.SCIENCE_COMPUTERS});

enum Difficulty { HARD, EASY, MEDIUM }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { MULTIPLE }

final typeValues = EnumValues({"multiple": Type.MULTIPLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
