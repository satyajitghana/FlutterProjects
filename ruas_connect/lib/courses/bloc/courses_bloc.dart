import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  @override
  CoursesState get initialState => InitialCoursesState();

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
