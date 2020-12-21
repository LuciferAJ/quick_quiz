import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_quiz/components/custom_button.dart';
import 'package:quick_quiz/components/custom_title.dart';
import 'package:quick_quiz/screens/homepage.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';


class QuizResults extends StatelessWidget {
  final subjectName;

  QuizResults({this.subjectName});

  final Box _box = Hive.box('quizData');

  @override
  Widget build(BuildContext context) {
    Future<bool> backToHome() async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
      return false;
    }

    return WillPopScope(
      onWillPop: backToHome,
      child: Scaffold(
        body: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/images/quiz background.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset('assets/animations/done.json'),
              customTitle(context,
                  'Score: ' + _box.get(subjectName + 'score').toString() + '/' +
                      (_box.get(subjectName + 'attemptedAnswers')).length
                          .toString()),
              customTitle(context, 'Quiz Completed!!'),
              verticalSpace(screenHeight(context) * 0.05),
              customButton(context, () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => HomePage()
                ), (route) => false);
              }, 'Back To Home')
            ],
          ),
        ),
      ),
    );
  }
}
