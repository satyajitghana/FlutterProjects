import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  @override
  DocumentsState get initialState => InitialDocumentsState();

  @override
  Stream<DocumentsState> mapEventToState(
    DocumentsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
