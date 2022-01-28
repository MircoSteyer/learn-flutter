import 'package:flutter/material.dart';
import 'package:udemy_flutter_basics/question.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionPosition = 0;
  final List _questions = [
    "What's your favorite animal?",
    "What's your favorite color?",
  ];

  void _answerQuestion() {
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
            Question(_questions[_questionPosition]),
            ElevatedButton(
              child: const Text("Answer 1"),
              onPressed: _answerQuestion,
            ),
            ElevatedButton(
              child: const Text("Answer 2"),
              onPressed: _answerQuestion,
            ),
            ElevatedButton(
              child: const Text("Answer 3"),
              onPressed: _answerQuestion,
            ),
          ],
        ),
      ),
    ));
  }
}
