import 'package:flutter/material.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

Widget customButton(BuildContext context, action, String text){
  return RaisedButton(
    onPressed:action,
    color: accentColor,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
    child: Text(text,style: quizTheme(context).subtitle2.apply(
        fontWeightDelta: 2,
        color: secondaryColor,
        letterSpacingFactor:2
    ),),
  );
}