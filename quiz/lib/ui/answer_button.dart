import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final bool _answer;
  final Function _onTap;

  AnswerButton(this._answer, this._onTap);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
            color: _answer == true ? Colors.greenAccent : Colors.redAccent,
            child: InkWell(
              onTap: () {
                _onTap();
                // print('You Pressed ' + answer.toString() + ' Button');
              },
              child: Center(
                // we've taken a container here, because a container has a property called decoration
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 8.0,),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    _answer == true ? 'True' : 'False',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )));
  }
}
