import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UploadEvent extends Equatable {
  UploadEvent([List props = const []]) : super(props);
}
