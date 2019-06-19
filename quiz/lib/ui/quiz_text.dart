import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionIdx;

  QuestionText(this._question, this._questionIdx);

  @override
  State<StatefulWidget> createState() {
    return QuestionTextState();
  }
}

// When you need to do an animation use TickerProviderStateMixin
// SingleTicker gives one AnimationController
// remove the Single to have multiple
class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double>
      _fontSizeAnimation; // this values goes from 0, 0.1, 0.2, . . . .1.0
  AnimationController _fontSizeanimationController;

  @override
  void initState() {
    _fontSizeanimationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    // this values goes from 0.0 0.1 0.2 . . . 0.8 0.9 1.0
    _fontSizeAnimation = CurvedAnimation(
        parent: _fontSizeanimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() {setState(() {});});
    _fontSizeanimationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeanimationController.reset();
      _fontSizeanimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white70,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            // This is known as String interpolation also use ${3+5} for more complex ones
            child: Text(
              'Statement ${widget._questionIdx} : ${widget._question}',
              style: TextStyle(fontSize: _fontSizeAnimation.value * 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          )),
    );
  }
}
