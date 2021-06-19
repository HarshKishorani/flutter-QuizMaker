import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(QuizMaker());
}

class QuizMaker extends StatefulWidget {
  @override
  _QuizMakerState createState() => _QuizMakerState();
}

class _QuizMakerState extends State<QuizMaker> {
  bool isLoggedin = false;

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  checkUserStatus() async {
    await HelperFunctions.getUserData().then((value) {
      setState(() {
        isLoggedin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (isLoggedin ?? false) ? Home() : SignIn(),
    );
  }
}
