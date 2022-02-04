import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/answer.dart';
import 'package:udemy_flutter_basics/question.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionPosition = 0;
/*  final List _questions = [
    "What is your favorite animal?",
    "What is your favorite color?",
  ];*/

  static const _questions = [
    {
      "questionText": "What is your favorite animal?",
      "answers": ["Rabbit", "Snake", "Elephant", "Lion"]
    },
    {
      "questionText": "What is your favorite color?",
      "answers": ["Black", "Red", "Green", "White"]
    },
    {
      "questionText": "What is your favorite dish?",
      "answers": ["Ramen", "Sushi", "Kebab", "Pizza"]
    },
  ];

  void _answerQuestion() {
    if (_questionPosition < _questions.length - 1) {
      print("[WARNING] questionindex ${_questionPosition}");
    }

    setState(() {
      _questionPosition++;
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
        child: Column(
          children: [
            Question(_questions[_questionPosition]["questionText"] as String),
            ...(_questions[_questionPosition]["answers"] as List<String>)
                .map((answer) => Answer(_answerQuestion, answer))
                .toList()
          ],
        ),
      ),
    ));
  }
}
