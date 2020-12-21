import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quick_quiz/app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String dirPath =
      (await path_provider.getApplicationDocumentsDirectory()).path;
  Hive.init(dirPath);
  await Hive.openBox("quizData");
  await Firebase.initializeApp();
  runApp(MyApp());
}
