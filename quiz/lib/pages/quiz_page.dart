import 'package:flutter/material.dart';
import 'package:quiz/ui/answer_button.dart';
import 'package:quiz/ui/quiz_text.dart';
import 'package:quiz/ui/correct_wrong_overlay.dart';
import 'package:quiz/utils/questions.dart';
import 'package:quiz/utils/quiz.dart';

// A Stateful Widget is a UI Component that can update when there are state changes
// every StatefulWidget is connected to a State, the Stateful Widget can only contain final values,
// i.e. immutable values, while the State can contain immultable values, setState() being called everytime
// updates the state and refreshes that part of the UI
class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizPageState();
}

// This is the State that is bound to the above StatefulWdiget
// the implementation is similar to that of a StatelessWidget
class QuizPageState extends State<QuizPage> {

  Question currQuestion;
  Quiz quiz = Quiz([
    Question(question: 'Elon Musk is Human', answer: false),
    Question(question: 'Pizza is Healthy', answer: true),
    Question(question: 'Flutter is Awesome', answer: true)
  ]);

  String questionText;
  int questionIdx;
  bool isCorrect;

  bool feedbackVisible = false;

  @override
  void initState() {
    super.initState();

    currQuestion = quiz.nextQuestion;
    questionText = currQuestion.question;
    questionIdx = quiz.questionsIdx;
  }

  void handleAnswer(bool answer) {
    isCorrect = currQuestion.answer == answer;
    quiz.answer(isCorrect);
    setState(() {
      feedbackVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            AnswerButton(true, () {
              print('True');
              handleAnswer(true);
            }),
            QuestionText(questionText, questionIdx),
            AnswerButton(false, () {
              print('False');
              handleAnswer(false);
            })
          ],
        ),
        feedbackVisible ? CorrectWrongOverlay(
          isCorrect, () {
            currQuestion = quiz.nextQuestion;
            setState(() {
              feedbackVisible = false;
              questionText = currQuestion.question;
              questionIdx = quiz.questionsIdx;
            });
        }) : Container()
      ],
    );
  }
}
