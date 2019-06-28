import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DocumentsEvent extends Equatable {
  DocumentsEvent([List props = const []]) : super(props);
}
