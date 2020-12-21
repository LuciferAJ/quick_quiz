import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_quiz/app.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';


class Greetings extends StatefulWidget {
  @override
  _GreetingsState createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  var userName;
  @override
  void initState() {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      setState(() {
        userName=value.data()['name'];
      });
      print(userName);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Welcome,",
                style: quizTheme(context)
                    .subtitle1
                    .apply(color: Colors.white70)),
            GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      color: accentColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                        Icons.exit_to_app,
                        color: Colors.white
                    ),
                  ),
                ),
                onTap: () {
                  HelperFunctions.saveUserLoggedInSharedPreference(
                      false);
                  FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp()),
                              (route) => false));
                })
          ],
        ),
        Text(userName??"",
          style: quizTheme(context)
              .headline5
              .apply(color: secondaryColor, fontWeightDelta: 2),
        ),
      ],
    );
  }
}
