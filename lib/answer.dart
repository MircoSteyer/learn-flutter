import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _answer;

  const Answer(this._onPressed, this._answer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        child: Text(_answer),
        onPressed: _onPressed,
      ),
    );
  }
}
