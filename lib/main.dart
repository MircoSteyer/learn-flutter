import "package:flutter/material.dart";
import 'package:udemy_flutter_basics/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Personal Expenses App",
      home: HomePage(),
    );
  }
}
