import 'package:flutter/material.dart';
import 'package:quick_quiz/components/homepage_widgets/homepage_greetings.dart';
import 'package:quick_quiz/components/homepage_widgets/playquiz_title.dart';
import 'package:quick_quiz/components/homepage_widgets/quiz_section.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: symHorizontalpx(30.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            verticalSpace(screenHeight(context)*0.01),
            Greetings(),
            verticalSpace(screenHeight(context)*0.05),
            playQuizTitle(context),
            QuizSection()
          ],
        ),

    );
  }
}
