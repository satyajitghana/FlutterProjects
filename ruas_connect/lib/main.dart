import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruas_connect/login/login.dart';
import 'package:ruas_connect/main_arena.dart';

import 'package:ruas_connect/repository/respository.dart';
import 'authentication_bloc/bloc.dart';
import 'package:ruas_connect/simple_bloc_delegate.dart';
import 'package:ruas_connect/splash_screen.dart';
import 'package:ruas_connect/home_screen.dart';
import 'package:ruas_connect/settings/settings.dart';
import 'package:ruas_connect/settings/bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final CoursesRepository coursesRepository = CoursesRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(
          builder: (BuildContext context) =>
              AuthenticationBloc(userRepository: userRepository)
                ..dispatch(AppStarted()),
        ),
        BlocProvider<SettingsBloc>(
          builder: (BuildContext context) =>
              SettingsBloc(userRepository: userRepository),
        ),
      ],
      child: App(
          userRepository: userRepository, courseRepository: coursesRepository),
    );
  }
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final CoursesRepository _coursesRepository;

  const App(
      {Key key,
      @required UserRepository userRepository,
      @required CoursesRepository courseRepository})
      : assert(userRepository != null),
        assert(courseRepository != null),
        _userRepository = userRepository,
        _coursesRepository = courseRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: BlocBuilder(
          bloc: BlocProvider.of<AuthenticationBloc>(context),
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Authenticated) {
//              return SplashScreen();
              return MainArenaPage();
            }
            if (state is Unauthenticated) {
              return LoginScreen(
                userRepository: _userRepository,
              );
            }
            // SetUserDetails is called only when Authenticated
            if (state is SetUserDetails) {
              return EditProfilePage(
                uid: state.uid,
                email: state.email,
              );
            }
          },
        ));
  }
}
