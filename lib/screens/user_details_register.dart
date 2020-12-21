import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_quiz/components/custom_button.dart';
import 'package:quick_quiz/components/custom_title.dart';
import 'package:quick_quiz/database/database_model.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/screens/homepage.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class UserDetailsForm extends StatefulWidget {
  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final GlobalKey<State> _formKey = GlobalKey<FormState>();
  String userName;
  bool userNameAutoValidate = false;
  bool isContinueButtonPressed = false;
  final TextEditingController _userNameController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        isContinueButtonPressed = true;
      });
      Map<String, dynamic> details = {
        'name': _userNameController.text,
      };
      databaseModel
          .uploadUserDetails( details)
          .whenComplete(() {
        HelperFunctions.userDetailsUploaded(true);
        Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()))
            .whenComplete(() {
          setState(() {
            isContinueButtonPressed = false;
          });
        });
      });
    }
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
        child: Padding(
          padding: symHorizontalpx(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(screenHeight(context) * 0.15),
                customTitle(context, 'Your Name'),
                verticalSpace(screenHeight(context) * 0.05),
                TextFormField(
                  validator: (userName) {
                    if (userName.length < 2) {
                      return 'Enter your Name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (userName) {
                    if (userName.toString().length > 0) {
                      setState(() {
                        userNameAutoValidate = true;
                      });
                    } else {
                      setState(() {
                        userNameAutoValidate = false;
                      });
                    }
                    setState(() {
                      this.userName = userName;
                    });
                  },
                  autovalidate: userNameAutoValidate,
                  controller: _userNameController,
                  style: quizTheme(context).subtitle1.apply(
                      color: Colors.black87, fontSizeDelta: 1.2, fontSizeFactor: 1),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: quizTheme(context).headline6.apply(
                        color: accentColor,
                        fontWeightDelta: 2,
                        fontSizeDelta: 0.8,
                        fontSizeFactor: 0.7),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    fillColor: secondaryColor,
                    filled: true,
                    errorStyle: quizTheme(context).caption.apply(
                        color: Colors.black87,
                        fontWeightDelta: 1,
                        fontSizeFactor: 1),
                    focusColor: accentColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  cursorColor: accentColor,

                ),
                verticalSpace(screenHeight(context) * 0.02),
                Align(
                    alignment: Alignment.centerRight,
                    child: customButton(context, validateAndSave, 'Continue'))
              ],
            ),
          ),
        ),
      ),
    );
  }


}
