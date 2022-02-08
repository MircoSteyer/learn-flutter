import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/quiz.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _showQuiz = true;
  var _quizScore = 0;

  void _endQuiz() {
    setState(() {
      _showQuiz = false;
    });
  }

  void _getQuizScore(int score) {
    setState(() {
      _quizScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("My Title"),
        centerTitle: true,
      ),
      body: Align(
          alignment: Alignment.center,
          child: _showQuiz
              ? Quiz(
                  onQuizEnd: _endQuiz,
                  sendQuizScore: _getQuizScore,
                )
              : Text("Quiz ended. Score: $_quizScore")),
    ));
  }
}
