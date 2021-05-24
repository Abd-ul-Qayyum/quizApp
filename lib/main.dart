import 'package:flutter/material.dart';
import 'package:quiz_app/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];
  int count = 0;
  int score = 0;

  void checkAnswer(bool upanswer) {
    setState(() {
      bool cans = quizBrain.getAnswer();
      if (count < quizBrain.getLenght()) {
        if (cans == upanswer) {
          score++;
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
        count++;
        if (count == quizBrain.getLenght()) {
          if (score >= 7) {
            Alert(
              context: context,
              type: AlertType.success,
              title: "Congrats",
              desc: "You Passed the Exam \n Your Score is: $score.",
              buttons: [
                DialogButton(
                  child: Text(
                    "COOL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          } else {
            Alert(
              context: context,
              type: AlertType.error,
              title: "Sorry",
              desc: "Try Again \n Your Score is: $score.",
              buttons: [
                DialogButton(
                  child: Text(
                    "Try Again",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          }
        }
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionBank(),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
          // widg(text: "True", color: Colors.green),
          Expanded(
              // ignore: deprecated_member_use
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      checkAnswer(true);
                    },
                    color: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ))),
          // widg(text: "False", color: Colors.red),
          Expanded(
              // ignore: deprecated_member_use
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            // ignore: deprecated_member_use
            child: FlatButton(
              onPressed: () {
                checkAnswer(false);
              },
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )),
          //todo: Add a row to here as score keeper,
          Row(
            children: scorekeeper,
          )
        ],
      ),
    );
  }
}
