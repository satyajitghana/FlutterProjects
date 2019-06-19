import 'package:quiz/utils/questions.dart';

// This is a usual calss, the private variables are usually referred with a underscore
class Quiz {
  List<Question> _questions;
  int _currQuestionIdx = -1;
  int _score = 0;

// this is the Constructor, notice that the this._questions is the argument, when the constructor is called
// with this, then the private variable is assigned with this argument value
  Quiz(this._questions) {
    _questions.shuffle();
  }

// Getter functions in dart
  List<Question> get questions => _questions;
  int get score => _score;
  int get length => questions.length;
  int get questionsIdx => _currQuestionIdx + 1;

  Question get nextQuestion {
    _currQuestionIdx++;
    if (_currQuestionIdx >= length) return null;
    return _questions[_currQuestionIdx];
  }

  void answer(bool isCorrect) {
    if (isCorrect) _score++;
  }
}
