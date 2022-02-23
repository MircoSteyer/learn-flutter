import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  final VoidCallback onQuizEnd;
  final void Function(int) sendQuizScore;
  static const _questions = [
    {
      "questionText": "What is your favorite animal?",
      "answers": [
        {"text": "Rabbit", "score": 2},
        {"text": "Snake", "score": 1},
        {"text": "Elephant", "score": 5},
        {"text": "Lion", "score": 3}
      ]
    },
    {
      "questionText": "What is your favorite color?",
      "answers": [
        {"text": "Black", "score": 3},
        {"text": "Red", "score": 2},
        {"text": "Green", "score": 5},
        {"text": "White", "score": 1}
      ]
    },
    {
      "questionText": "What is your favorite dish?",
      "answers": [
        {"text": "Ramen", "score": 3},
        {"text": "Sushi", "score": 1},
        {"text": "Kebab", "score": 2},
        {"text": "Pizza", "score": 5}
      ]
    },
  ];

  const Quiz({required this.onQuizEnd, required this.sendQuizScore, Key? key})
      : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _questionPosition = 0;
  var _score = 0;

  void _answerQuestion({required int score}) {
    setState(() {
      _score += score;

      print("[INFO] $_score");
    });

    if (_questionPosition >= Quiz._questions.length - 1) {
      widget.onQuizEnd();
      widget.sendQuizScore(_score);
    } else {
      setState(() {
        _questionPosition++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(Quiz._questions[_questionPosition]["questionText"] as String),
        ...(Quiz._questions[_questionPosition]["answers"]
                as List<Map<String, Object>>)
            .map((answer) => Answer(
                () => _answerQuestion(score: answer["score"] as int),
                answer["text"] as String))
            .toList()
      ],
    );
  }
}
