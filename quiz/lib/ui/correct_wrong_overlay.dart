import 'dart:math';

import 'package:flutter/material.dart';

class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCorrect;
  final Function _onTap;

  CorrectWrongOverlay(this._isCorrect, this._onTap);

  @override
  State<StatefulWidget> createState() {
    return CorrectWrongOverlayState();
  }
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();

    _iconAnimationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() {
      setState(() {});
    });
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        onTap: () => widget._onTap()
        // {
        //   widget._onTap();
        //   print('Clicked Overlay')
        // }
        ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child:  Transform.rotate(child: Icon(
                widget._isCorrect ? Icons.done : Icons.clear,
                size: _iconAnimation.value * 80.0,
                color: widget._isCorrect ? Colors.green : Colors.red,
              ),
              angle: _iconAnimation.value * 2* pi,)
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Text(widget._isCorrect ? 'Correct !' : 'Wrong !',
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          ],
        ),
      ),
    );
  }
}
