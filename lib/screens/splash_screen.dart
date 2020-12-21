import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/screens/authentication/sign_in.dart';
import 'package:quick_quiz/screens/homepage.dart';
import 'package:quick_quiz/screens/user_details_register.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Timer _timer;
  bool isUserLoggedIn;
  bool isUserDetailsUploaded;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedINSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  getUserDetailsUploadedStatus() async {
    await HelperFunctions.getUserDetailsUploadedStatus().then((value) {
      setState(() {
        isUserDetailsUploaded = value;
      });
    });
  }

  @override
  void initState() {
    getLoggedInState();
    getUserDetailsUploadedStatus();
    navigation();
    super.initState();
  }

  navigation() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      isUserLoggedIn != null && isUserDetailsUploaded != null
          ? isUserLoggedIn
              ? isUserDetailsUploaded?Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage())):Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => UserDetailsForm()))
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => SignIn()))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => SignIn()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/quiz background.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: Hero(
            tag: 'Logo',
            child: Image.asset(
              'assets/images/quiz time.png',
              height: screenWidth(context) * 0.6,
              width: screenWidth(context) * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
