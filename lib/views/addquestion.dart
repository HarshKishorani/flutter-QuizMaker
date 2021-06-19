import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/appbar_title.dart';
import 'package:quizmaker/widgets/button.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool isLoading = false;
  DatabaseService databaseService = DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionData = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      await databaseService
          .addQuestionData(questionData, widget.quizId)
          .then((value) {
        setState(() {
          isLoading = false;
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
                        return value.isEmpty ? "Enter Question" : null;
                      },
                      onChanged: (value) {
                        question = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Question",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter Option1" : null;
                      },
                      onChanged: (value) {
                        option1 = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Option 1 (Correct Answer)",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter Option 2" : null;
                      },
                      onChanged: (value) {
                        option2 = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Option 2",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter option 3 " : null;
                      },
                      onChanged: (value) {
                        option3 = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Option 3",
                      ),
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Enter option 4 " : null;
                      },
                      onChanged: (value) {
                        option4 = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Option 4",
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: button(
                              context: context,
                              text: "Submit",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        GestureDetector(
                            onTap: () => uploadQuestionData(),
                            child: button(
                                context: context,
                                text: "Add Question",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36))
                      ],
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ),
            ),
    );
  }
}
