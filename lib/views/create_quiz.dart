import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestion.dart';
import 'package:quizmaker/widgets/appbar_title.dart';
import 'package:quizmaker/widgets/button.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl, title, description, quizId;

  DatabaseService databaseService = DatabaseService();

  bool isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImgurl": imageUrl,
        "quizTitle": title,
        "quizDescription": description
      };

      await databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: appBar(context),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter Image Url" : null;
                      },
                      onChanged: (value) {
                        imageUrl = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Quiz Image Url",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter Quiz Title" : null;
                      },
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter Description" : null;
                      },
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Quiz Description",
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () =>
                            createQuizOnline(), //because on tap needs a void function
                        child: button(context: context, text: 'Create Quiz')),
                    SizedBox(height: 35),
                  ],
                ),
              ),
            ),
    );
  }
}
