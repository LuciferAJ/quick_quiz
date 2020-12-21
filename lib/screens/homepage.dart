import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:quick_quiz/components/homepage_widgets/homepage_body.dart';
import 'package:quick_quiz/database/database_model.dart';
import 'package:quick_quiz/services/API_manager.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  Box _box;
  DatabaseModel databaseModel = DatabaseModel();

  uploadAPIData() {
    QuizAPIManager.getQuizData(QuizAPIManager.mathsCategoryURL).then((value) {
      _box.put('Maths', value);
      return databaseModel.uploadAPI('Maths', {'results': value});
    }).whenComplete(() =>
        QuizAPIManager.getQuizData(QuizAPIManager.computerCategoryURL).then(
            (value) {
          _box.put('Computer', value);
          databaseModel.uploadAPI('Computer', {'results': value});
        }).whenComplete(() =>
            QuizAPIManager.getQuizData(QuizAPIManager.scienceCategoryURL)
                .then((value) {
              _box.put('Science', value);
              databaseModel.uploadAPI('Science', {'results': value});
            }).whenComplete(() =>
                    QuizAPIManager.getQuizData(QuizAPIManager.sportsCategoryURL)
                        .then((value) {
                      _box.put('Sports', value);
                      databaseModel.uploadAPI('Sports', {'results': value});
                    }).whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                    }))));
  }

  @override
  void initState() {
    _box = Hive.box('quizData');
    uploadAPIData();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage('assets/images/quiz background.png'),fit: BoxFit.cover)
    ),
      child:isLoading? Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'Logo',
            child: Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(accentColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Loading...',
            style: quizTheme(context).subtitle1
      .apply(color: secondaryColor)),
          )
        ],
      )
      :HomePageBody()
    ));
  }
}
