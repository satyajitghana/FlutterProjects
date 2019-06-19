import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import './pages/quiz_page.dart';

// MaterialApp creates the basic structure of the App, of placement of stuffs
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: QuizPage(),
    ),
  ));
}
