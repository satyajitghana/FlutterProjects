import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/authentication_bloc/bloc.dart';
import 'settings.dart';
import 'package:ruas_connect/models/models.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            // If Edit is successful then refresh this page
            onPressed: () => Navigator.push(
              context, 
                MaterialPageRoute(builder: (context) => EditProfilePage()),
            ),
          ),
        ],
      ),
      body: Material(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileDetails(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: RaisedButton.icon(
                      color: Colors.blueAccent,
                      label: Text('Reset Password'),
                      icon: Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: RaisedButton.icon(
                      color: Colors.redAccent,
                      label: Text('Logout'),
                      icon: Icon(Icons.warning),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .dispatch(LoggedOut());
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey,
              ),
              padding: const EdgeInsets.all(40.0),
              child: Image.asset(
                'assets/kitty.png',
                width: 160.0,
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Satyajit Ghana'),
              subtitle: Text('Email : satyajitghana7@gmail.com'),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: ListTile(
              leading: Icon(Icons.streetview),
              title: Text('CSE'),
              subtitle: Text('Branch'),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text('SEMESTER 03'),
              subtitle: Text('Semester'),
            ),
          ),
        ],
      ),
    );
  }
}
