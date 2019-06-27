import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UploadState extends Equatable {
  UploadState([List props = const []]) : super(props);
}

class InitialUploadState extends UploadState {}
