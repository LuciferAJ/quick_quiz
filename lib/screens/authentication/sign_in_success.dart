import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_quiz/database/database_model.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/screens/homepage.dart';
import 'package:quick_quiz/screens/user_details_register.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class SignInSuccess extends StatefulWidget {
  @override
  _SignInSuccessState createState() => _SignInSuccessState();
}

class _SignInSuccessState extends State<SignInSuccess> {
  DatabaseModel databaseModel = DatabaseModel();
  Timer timer;
  FirebaseAuth auth;
  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 750), (timer) async {
      databaseModel
          .getUserDetailsStatus(FirebaseAuth.instance.currentUser.uid)
          .then((value) {
        if (value.data()['name'] != null) {
          HelperFunctions.userDetailsUploaded(true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UserDetailsForm()));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
              tag: 'Logo',
              child: Icon(
                Icons.check_circle,
                color: accentColor,
                size: 80,
              )),
          verticalSpace(20),
          Text(
            'Successfully Signed-In',
            style: quizTheme(context).headline6.apply(color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
