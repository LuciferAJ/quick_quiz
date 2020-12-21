import 'package:flutter/material.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

Widget playQuizTitle(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('Let\'s Play',style: quizTheme(context).headline5.apply(
        color: secondaryColor,
        fontWeightDelta: 2,
        fontSizeFactor: 1.2,
        fontSizeDelta: 1
      ),),
      Text("Choose a category to start playing",
          style: quizTheme(context)
              .subtitle1
              .apply(color: secondaryColor)),

    ],
  );
}