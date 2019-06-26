import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/authentication_bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/cat_one.jpg'),
                ),
              ),
              Card(
                elevation: 5.0,
                child: Container(
                  width: 200.0,
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Text('Kittiee', style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
