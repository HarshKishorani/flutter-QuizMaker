import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/results.dart';
import 'package:quizmaker/widgets/appbar_title.dart';
import 'package:quizmaker/widgets/option_tile.dart';

int total = 0;
int correct = 0;
int incorrect = 0;
int notAttempted = 0;

class PlayQuiz extends StatefulWidget {
  final String quizId;

  PlayQuiz({@required this.quizId});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot snapshot;

  Question createQuestion(DocumentSnapshot snapshot) {
    Question question = Question();
    question.question = snapshot.data()["question"];

    List<String> options = [
      snapshot.data()["option1"],
      snapshot.data()["option2"],
      snapshot.data()["option3"],
      snapshot.data()["option4"]
    ];

    options.shuffle();

    question.option1 = options[0];
    question.option2 = options[1];
    question.option3 = options[2];
    question.option4 = options[3];
    question.correctOption = snapshot.data()["option1"];
    question.answered = false;

    return question;
  }

  @override
  void initState() {
    databaseService.getQuestions(widget.quizId).then((value) {
      snapshot = value;
      notAttempted = 0;
      correct = 0;
      incorrect = 0;
      total = snapshot.docs.length;
      print("Total = $total, QuizId : ${widget.quizId}");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            snapshot != null
                ? Container(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.docs.length,
                      itemBuilder: (context, index) {
                        return QuestionTile(
                          question: createQuestion(snapshot.docs[index]),
                          index: index,
                        );
                      },
                    ),
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Results(
                      correct: correct,
                      incorrect: incorrect,
                      total: total,
                    ))),
      ),
    );
  }
}

class QuestionTile extends StatefulWidget {
  final Question question;
  final int index;
  QuestionTile({this.question, this.index});

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1} : ${widget.question.question}",
            style: TextStyle(fontSize: 19, color: Colors.black87),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                ///correct
                if (widget.question.option1 == widget.question.correctOption) {
                  optionSelected = widget.question.option1;
                  widget.question.answered = true;
                  correct += 1;
                  notAttempted -= 1;
                  print(widget.question.correctOption);
                  setState(() {});
                } else {
                  optionSelected = widget.question.option1;
                  widget.question.answered = true;
                  incorrect += 1;
                }
              }
            },
            child: OptionTile(
              text: widget.question.option1,
              correctAnswer: widget.question.correctOption,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                ///correct
                if (widget.question.option2 == widget.question.correctOption) {
                  optionSelected = widget.question.option2;
                  widget.question.answered = true;
                  correct += 1;
                  notAttempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.question.option2;
                  widget.question.answered = true;
                  incorrect += 1;
                }
              }
            },
            child: OptionTile(
              text: widget.question.option2,
              correctAnswer: widget.question.correctOption,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                ///correct
                if (widget.question.option3 == widget.question.correctOption) {
                  optionSelected = widget.question.option3;
                  widget.question.answered = true;
                  correct += 1;
                  notAttempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.question.option3;
                  widget.question.answered = true;
                  incorrect += 1;
                }
              }
            },
            child: OptionTile(
              text: widget.question.option3,
              correctAnswer: widget.question.correctOption,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                ///correct
                if (widget.question.option4 == widget.question.correctOption) {
                  optionSelected = widget.question.option4;
                  widget.question.answered = true;
                  correct += 1;
                  notAttempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.question.option4;
                  widget.question.answered = true;
                  incorrect += 1;
                }
              }
            },
            child: OptionTile(
              text: widget.question.option4,
              correctAnswer: widget.question.correctOption,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
