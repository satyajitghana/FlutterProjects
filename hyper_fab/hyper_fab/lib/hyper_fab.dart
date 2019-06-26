library hyper_fab;
import 'package:flutter/material.dart';

class HyperFABButton extends FloatingActionButton {
  final FloatingActionButton currentButton;
  final String labelText;

  HyperFABButton(this.currentButton, this.labelText);

}

class HyperFAB extends StatefulWidget {
  @override
  _HyperFABState createState() => _HyperFABState();
}

class _HyperFABState extends State<HyperFAB> {

  

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
