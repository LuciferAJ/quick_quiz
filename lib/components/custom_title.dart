import 'package:flutter/material.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

Widget customTitle(BuildContext context,String title){
  return Text(title,
      style: quizTheme(context).headline5.apply(
        color: secondaryColor,
        fontWeightDelta: 2,
      ));
}