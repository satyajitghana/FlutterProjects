import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ruas_connect/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  @override
  UploadState get initialState => UploadFormState.empty();

  @override
  Stream<UploadState> transform(
      Stream<UploadEvent> events, Stream<UploadState> next(UploadEvent event)) {
    final observableStream = events as Observable<UploadEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! TitleChanged && event is! DescriptionChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is TitleChanged || event is DescriptionChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is TitleChanged) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is DescriptionChanged) {
      yield* _mapDescriptionChangedToState(event.description);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.title, event.description);
    }
  }

  /// Title will have a minimum of 5 and maximum of 30 characters
  /// Description will have a minimum of 5 and maximum of 120 characters

  Stream<UploadState> _mapTitleChangedToState(String title) async* {
    yield (currentState as UploadFormState).update(
      isTitleValid: title.length > 5 && title.length < 20
//      Validators.isMinimumMaximumLengthText(title, 5, 30),
    );
  }

  Stream<UploadState> _mapDescriptionChangedToState(String description) async* {
    yield (currentState as UploadFormState).update(
      isDescriptionValid: description.length > 5 && description.length < 120
//          Validators.isMinimumMaximumLengthText(description, 5, 120),
    );
  }

  Stream<UploadState> _mapFormSubmittedToState(
    String title,
    String description,
  ) async* {
    try {
      // TODO: Logic Here
      print('{ _mapFormSubmittedToState : $title , $description }');
      yield UploadFormState.success();
    } catch (_) {
      yield UploadFormState.failure();
    }
  }
}
