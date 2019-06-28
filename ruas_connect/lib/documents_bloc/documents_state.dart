import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
abstract class DocumentsState extends Equatable {
  DocumentsState([List props = const []]) : super(props);
}

class InitialDocumentsState extends DocumentsState {}

class LoadedDocumentsState extends DocumentsState {
  final DocumentSnapshot lastSnapshot;
  final bool hasMoreDocuments;

  LoadedDocumentsState(
      {@required this.hasMoreDocuments, @required this.lastSnapshot})
      : super([hasMoreDocuments, lastSnapshot]);
}

class LoadingDocumentsState extends DocumentsState {}
