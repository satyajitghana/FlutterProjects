import 'package:flutter/material.dart';
import 'package:quiz/ui/answer_button.dart';

// A Stateful Widget is a UI Component that can update when there are state changes
// every StatefulWidget is connected to a State, the Stateful Widget can only contain final values,
// i.e. immutable values, while the State can contain immultable values, setState() being called everytime
// updates the state and refreshes that part of the UI
class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizPageState();
}

// This is the State that is bound to the above StatefulWdiget
// the implementation is similar to that of a StatelessWidget
class QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[AnswerButton(true), AnswerButton(false)],
        )
      ],
    );
  }
}

class TruePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      // True Button
      color: Colors.greenAccent,
      child: InkWell(
        onTap: () {
          print('You Pressed True Button');
        },
        child: Center(
          child: Container(
            child: Text('True'),
          ),
        ),
      ),
    ));
  }
}

class FalsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      // False Button
      color: Colors.redAccent,
      child: InkWell(
        onTap: () {
          print('You Pressed False Button');
        },
        child: Center(
          child: Container(
            child: Text('False'),
          ),
        ),
      ),
    ));
  }
}
