import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_quiz/components/custom_button.dart';
import 'package:quick_quiz/components/custom_title.dart';
import 'package:quick_quiz/components/signin/signin_section.dart';
import 'package:quick_quiz/database/database_model.dart';
import 'package:quick_quiz/helper_functions.dart';
import 'package:quick_quiz/screens/authentication/sign_in_success.dart';
import 'package:quick_quiz/services/auth.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class SignInBody extends StatefulWidget {
  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  String userEmail;
  String userPassword;
  bool emailAutoValidate = false;
  bool passWordAutoValidate = false;
  bool isSignInButtonPressed = false;
  final GlobalKey<State> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  DatabaseModel databaseModel = DatabaseModel();

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        isSignInButtonPressed = true;
      });
      _auth
          .signInWithEmailAndPassword(
              _emailController.text.trim(), _passwordController.text.trim())
          .then((value) {
        if (value != null) {
          databaseModel.getUserDetailsStatus(value.uid).then((snapshot) {
            if (snapshot.data() != null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                HelperFunctions.saveUserLoggedInSharedPreference(true);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(
                        builder: (context) => SignInSuccess()))
                    .whenComplete(() => setState(() {
                          isSignInButtonPressed = false;
                        }));
              });
            } else {
              databaseModel.setUser(value.uid, value.email).whenComplete(() {
                HelperFunctions.saveUserLoggedInSharedPreference(true);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(
                        builder: (context) => SignInSuccess()))
                    .whenComplete(() => setState(() {
                          isSignInButtonPressed = false;
                        }));
              });
            }
          });
        } else {
          setState(() {
            isSignInButtonPressed = false;
          });
          Fluttertoast.showToast(
              msg: "Invalid Email or Password!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 13.0);
        }
      });
    } else {
      print('Form is invalid');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/quiz background.png'),
              fit: BoxFit.cover)),
      child: signInSection(context),
    );
  }

  Widget signInSection(BuildContext context) {
    return Padding(
      padding: symHorizontalpx(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace(screenHeight(context) * 0.15),
            customTitle(context, 'Sign In'),
            verticalSpace(screenHeight(context) * 0.05),
            TextFormField(
              validator: (email) {
                if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email)) {
                  return null;
                } else {
                  return 'Invalid Email address';
                }
              },
              onChanged: (email) {
                setState(() {
                  userEmail = email;
                  emailAutoValidate = true;
                });
              },
              autovalidate: emailAutoValidate,
              controller: _emailController,
              style: quizTheme(context).subtitle1.apply(
                  color: Colors.black87, fontSizeDelta: 1.2, fontSizeFactor: 1),
              decoration: InputDecoration(
                labelText: 'Email',
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
            TextFormField(
              onChanged: (value) {
                setState(() {
                  passWordAutoValidate = true;
                });
              },
              autovalidate: passWordAutoValidate,
              validator: (password) {
                if (password.length < 2) {
                  return 'Incorrect Password';
                } else {
                  return null;
                }
              },
              controller: _passwordController,
              obscureText: true,
              style: quizTheme(context).subtitle1.apply(
                  color: Colors.black87, fontSizeDelta: 1.2, fontSizeFactor: 1),
              decoration: InputDecoration(
                errorStyle: quizTheme(context).caption.apply(
                    color: Colors.black87,
                    fontWeightDelta: 1,
                    fontSizeFactor: 1),
                labelText: 'Password',
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
            isSignInButtonPressed
                ? Hero(
              tag: 'SignInButton',
              child: Center(
                child: Container(
                  height: screenHeight(context) * 0.08,
                  width: screenWidth(context) * 0.2,
                  child: Center(
                    child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(accentColor)),
                  ),
                ),
              ),
            )
                : Align(
                alignment: Alignment.centerRight,
                child: Hero(
                    tag: 'Logo',
                    child: customButton(context, validateAndSave, 'Sign In')))
          ],
        ),
      ),
    );
  }
}
