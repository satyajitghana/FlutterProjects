import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/login/login.dart';

import 'package:flutter_firebase_login/repository/user_repository.dart';
import 'authentication_bloc/bloc.dart';
import 'package:flutter_firebase_login/simple_bloc_delegate.dart';
import 'package:flutter_firebase_login/splash_screen.dart';
import 'package:flutter_firebase_login/home_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: App(userRepository: userRepository),
    );
  }
}

class App extends StatelessWidget {

  final UserRepository _userRepository;

  const App({Key key, @required UserRepository userRepository }) : assert(userRepository != null) ,_userRepository = userRepository, super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName,);
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository,);
          }
        },
      )
    );
  }
}
