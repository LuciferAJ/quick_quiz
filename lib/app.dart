import 'package:flutter/material.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/screens/authentication/sign_in.dart';
import 'package:quick_quiz/screens/homepage.dart';
import 'package:quick_quiz/screens/splash_screen.dart';
import 'package:quick_quiz/services/internet_connectivity.dart';
import 'package:quick_quiz/shared/theme_data.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InternetConnectivity internetConnectivity;
  @override
  void initState() {
    InternetConnectivity.initConnectivity();
    InternetConnectivity.connectivity.onConnectivityChanged.listen(InternetConnectivity.updateConnectionStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: quizAppTheme,
      home:  Builder(builder: (BuildContext context) {
        return Splashscreen();
      }),
    );
  }
}