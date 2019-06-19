import 'package:flutter/material.dart';

// This is the Landing Page that contains the main UI,
// the InkWell is basically the whole page as a button, it gives that ink'ed animation when tapped
// Material() is considered like a empty page on which you can put Widgets
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.greenAccent,
      child: InkWell(
        onTap: () {
          print('You Tapped the page');
        },
        child: Column(
          // this is to center the text vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Let' 's Quiz',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Tap to Start!',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
