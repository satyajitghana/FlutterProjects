import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/authentication_bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Settings'),
      ),
      body: Material(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                RaisedButton.icon(
                  elevation: 3.0,
                  color: Colors.redAccent,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(30.0),
//                ),
                  label: Text('Logout'),
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .dispatch(LoggedOut());
                    Navigator.pop(context);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
