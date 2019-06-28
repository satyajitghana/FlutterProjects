import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:ruas_connect/repository/respository.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final String arenaName, courseCode;

  DocumentsBloc({@required this.arenaName, @required this.courseCode});

  @override
  DocumentsState get initialState => InitialDocumentsState();

  @override
  Stream<DocumentsState> mapEventToState(
    DocumentsEvent event,
  ) async* {
    if (event is LoadDocuments) {
      yield* _mapLoadDocumentsToState();
    } else if (event is LoadMoreDocuments) {
      yield* _mapLoadMoreDocumentsToState(event.fromSnapshot);
    }
  }

  /// setting N = 8

  Stream<DocumentsState> _mapLoadDocumentsToState() async* {
    yield LoadingDocumentsState();
    List<DocumentSnapshot> docs = await CoursesRepository.getNDocumentsOf(arenaName, courseCode, 8);
    bool hasMoreDocs = docs.length == 8;
    yield LoadedDocumentsState(
      hasMoreDocuments: hasMoreDocs,
      lastSnapshot: docs[docs.length-1]
    );
  }

  Stream<DocumentsState> _mapLoadMoreDocumentsToState(
      DocumentSnapshot fromSnapshot) async* {
    yield LoadingDocumentsState();
    List<DocumentSnapshot> docs = await CoursesRepository.getNDocumentsFrom(
        arenaName, courseCode, 8, fromSnapshot);
    bool hasMoreDocs = docs.length == 8;
    yield LoadedDocumentsState(
      hasMoreDocuments: hasMoreDocs,
      lastSnapshot: docs[docs.length-1]
    );
  }
}
