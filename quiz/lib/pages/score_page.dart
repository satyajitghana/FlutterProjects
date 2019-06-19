import 'package:flutter/material.dart';
import './landing_page.dart';

class ScorePage extends StatelessWidget {

  final int _score;
  final int _totalQuestions;

  ScorePage(this._score, this._totalQuestions);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Your Score', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 50.0)),
          Text('$_score of $_totalQuestions', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 50.0)),
          Padding(padding: EdgeInsets.only(bottom: 20.0),),
          RawMaterialButton(
            onPressed: () => {
              Navigator
              .of(context)
              .pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => LandingPage()),
                (Route route) => route == null
              )},
              child: Icon(Icons.arrow_right, color: Colors.indigoAccent, size: 80.0,),
              fillColor: Colors.white70,
              shape: CircleBorder(),
              elevation: 2.0,
              padding: EdgeInsets.all(10.0),
          )
        ],
      ),
    );
  }
}