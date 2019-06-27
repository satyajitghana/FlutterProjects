import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ruas_connect/models/models.dart';

@immutable
abstract class UploadEvent extends Equatable {
  UploadEvent([List props = const []]) : super(props);
}

class TitleChanged extends UploadEvent {
  final String title;

  TitleChanged({@required this.title}) : super([title]);

  @override
  String toString() => 'TitleChanged { title : $title }';
}

class DescriptionChanged extends UploadEvent {
  final String description;

  DescriptionChanged({@required this.description}) : super([description]);

  @override
  String toString() => 'DescriptionChanged { description : $description }';


}

class Submitted extends UploadEvent {
  final String title;
  final String description;

  Submitted({@required this.title, @required this.description})
      : super([title, description]);

  @override
  String toString() => 'Submitted { title : $title, description : $description }';
}

class StartUpload extends UploadEvent {
  final UploadedFile uploadedFile;

  StartUpload({ @required this.uploadedFile } )
    : super([uploadedFile]);

  @override
  String toString() => 'StartUpload { uploadedFile : $uploadedFile }';
}
