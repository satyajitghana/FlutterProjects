import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DocumentsState extends Equatable {
  DocumentsState([List props = const []]) : super(props);
}

class InitialDocumentsState extends DocumentsState {}
