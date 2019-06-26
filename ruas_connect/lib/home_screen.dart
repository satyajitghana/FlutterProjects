import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/authentication_bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hello $name')
    );
  }
}
