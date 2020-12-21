import 'package:flutter/material.dart';
import 'package:quick_quiz/database/database_model.dart';
import 'package:quick_quiz/database/quiz_section_data.dart';
import 'file:///C:/Users/ajay8/Desktop/quick_quiz/lib/screens/quiz/quiz.dart';
import 'package:quick_quiz/services/API_manager.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class QuizSection extends StatelessWidget {
  final DatabaseModel databaseModel = DatabaseModel();
  final quizSectionData = QuizSectionData();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            quizTiles(context, quizSectionData.quizSection[0]['title'],
                quizSectionData.quizSection[0]['image']),
            quizTiles(context, quizSectionData.quizSection[1]['title'],
                quizSectionData.quizSection[1]['image']),
          ],
        ),
        Column(
          children: <Widget>[
            verticalSpace(screenHeight(context) * 0.1),
            quizTiles(context, quizSectionData.quizSection[2]['title'],
                quizSectionData.quizSection[2]['image']),
            quizTiles(context, quizSectionData.quizSection[3]['title'],
                quizSectionData.quizSection[3]['image']),
          ],
        ),
      ],
    );
  }


  Widget quizTiles(BuildContext context, String title, String imagePath) {
    return Padding(
      padding: symVerticalpx(screenHeight(context) * 0.01),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Quiz(subjectName: title,))
              );
            },
            child: Container(
              height: screenWidth(context) * 0.35,
              width: screenWidth(context) * 0.35,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 20,
                      shadowColor: Colors.deepPurpleAccent[400],
                      child: Container(
                        height: screenWidth(context) * 0.27,
                        width: screenWidth(context) * 0.27,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_forward,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    imagePath ?? '', height: screenWidth(context) * 0.25,),
                ],
              ),
            ),
          ),
          Text(title ?? '', style: quizTheme(context)
              .subtitle1
              .apply(color: secondaryColor, fontWeightDelta: 2),)
        ],
      ),
    );
  }
}