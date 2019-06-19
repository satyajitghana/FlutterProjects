import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  bool answer;

  AnswerButton(this.answer);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color: answer == true ? Colors.greenAccent : Colors.redAccent,
      child: InkWell(
        onTap: () {
          print('You Pressed ' + answer.toString() +' Button');
        },
        child: Center(
          child: Container(
            child: Text(answer == true ? 'True' : 'False'),
          ),
        ),
      ),
    ));
    ;
  }
}
