import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quick_quiz/components/custom_button.dart';
import 'package:quick_quiz/components/custom_title.dart';
import 'package:quick_quiz/screens/quiz/quiz_results.dart';
import 'package:quick_quiz/shared/theme_colors.dart';
import 'package:quick_quiz/shared/ui_helpers.dart';

class QuizBody extends StatefulWidget {
  final String subjectName;
  QuizBody({this.subjectName});

  @override
  _QuizBodyState createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  bool isLoading = true;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  List answers = [];
  List questions = [];
  List correctAnswerIndex=[];
  List attemptedAnswer;
  Map<dynamic, dynamic> quizData = {};
  setQuizData() {
    FirebaseDatabase.instance
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid.toString() +
            '/subjects/' +
            widget.subjectName)
        .once()
        .then((value) {
      setState(() {
        quizData = value.value;
      });
    }).whenComplete(() {
      for (var i in quizData['results']['results']) {
        Random random = Random();
        int randomIndex = random.nextInt(4);
        correctAnswerIndex.add(randomIndex);
        var answer = [];
        for (var j in i['incorrect_answers']) {
          answer.add(j);
        }
        answer.insert(randomIndex, i['correct_answer']);
        questions.add(i['question']);
        answers.add(answer);
      }
      attemptedAnswer=List.filled(questions.length, null);
      setState(() {
        isLoading = false;
      });
    });
  }
submitAnswer(int pageIndex,int answerIndex){
    setState(() {
      attemptedAnswer[pageIndex]=answerIndex;

    });
}

submitNavigation(){
   return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context)=> QuizResults())
    );
}
  
  @override
  void initState() {
    setQuizData();
    super.initState();
  }
@override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/images/quiz background.png'),
                    fit: BoxFit.cover)),
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: quizData != null
                    ? quizData['results']['results'].length
                    : 0,
                itemBuilder: (context, pageIndex) => Padding(
                      padding: symHorizontalpx(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          verticalSpace(screenHeight(context) * 0.1),
                          Text('Question: '+(pageIndex+1).toString()+'/'+questions.length.toString(),
                          style: quizTheme(context).caption.apply(
                            color: secondaryColor,
                            fontSizeFactor: 1.2,
                            fontWeightDelta: 2
                          ),
                          ),
                          verticalSpace(screenHeight(context) * 0.05),
                          customTitle(
                              context,
                              quizData['results']['results'][pageIndex]['question']
                                  .toString()),
                          verticalSpace(screenHeight(context) * 0.03),
                          ListView.builder(
                            padding: allCustompx(0.0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: answers[pageIndex].length,
                            itemBuilder: (context, tileIndex) => Container(
                              decoration: BoxDecoration(
                                  color: attemptedAnswer[pageIndex]==null?secondaryColor:
                                  attemptedAnswer[pageIndex]==tileIndex?(attemptedAnswer[pageIndex]==correctAnswerIndex[pageIndex]?Colors.green:Colors.red)
                                      :(correctAnswerIndex[pageIndex]==tileIndex?Colors.green:secondaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: symVerticalpx(6.0),
                              child: ListTile(
                                  onTap: attemptedAnswer[pageIndex]==null? () {
                                    submitAnswer(pageIndex, tileIndex);
                                  }:null,
                                  title: Center(
                                    child: Text(
                                      (answers[pageIndex][tileIndex]).toString(),
                                      style: quizTheme(context).subtitle1.apply(
                                          fontWeightDelta: 2,
                                          fontSizeFactor: 1.2,
                                          color: attemptedAnswer[pageIndex]==null?primaryColor:
                                          (attemptedAnswer[pageIndex]==tileIndex?Colors.white
                                              :(correctAnswerIndex[pageIndex]==tileIndex?Colors.white:primaryColor))),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ),
                          verticalSpace(screenHeight(context) * 0.03),
                          Center(
                            child: customButton(context,(questions.length-1)!=pageIndex? () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }:
                            submitNavigation, (questions.length-1)!=pageIndex?'Next':'Submit'),
                          )
                        ],
                      ),
                    )),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(accentColor)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Loading...',
                    style: quizTheme(context)
                        .subtitle1
                        .apply(color: secondaryColor)),
              )
            ],
          );
  }
}
