import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ruas_connect/settings/bloc/bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState => InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
