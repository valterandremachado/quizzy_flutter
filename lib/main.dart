import 'package:flutter/material.dart';
// import 'package:quizzy/question.dart';
import 'package:quizzy/quiz_bank.dart';

void main() {
  runApp(Quizzy());
}

// For static UI
class Quizzy extends StatelessWidget {
  const Quizzy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[600],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuizzyMainView(),
          ),
        ),
      ),
    );
  }
}

// QuizBank Object
QuizBank quizBank = QuizBank();

// For dynamic UI
class QuizzyMainView extends StatefulWidget {
  const QuizzyMainView({Key? key}) : super(key: key);
  @override
  _QuizzyMainViewState createState() => _QuizzyMainViewState();
}

class _QuizzyMainViewState extends State<QuizzyMainView> {
  //TODO: Variables and functions go here
  bool _visible = true;
  bool _playAgainIsVisible = false;

  List<Icon> scoreBoard = [];
  String displayQuest = '';

  void checkAnswerAccurancy(bool selectedAnswer) {
    bool correctAnswer = quizBank.getAnswer();

    setState(() {
      if (_visible != true) {
        return;
      }

      if (correctAnswer == selectedAnswer) {
        scoreBoard.add(
          Icon(Icons.check, color: Colors.green),
        );
      } else {
        scoreBoard.add(
          Icon(Icons.close, color: Colors.red),
        );
      }

      if (quizBank.isLastItem() == true) {
        _visible = false;
        _playAgainIsVisible = !_visible;
        print('isLastItem');
      } else {
        print('isNot LastItem');
        _visible = true;
        _playAgainIsVisible = !_visible;
      }

      quizBank.nextQuest();
    });
  }

  void handlePlayAgainButtonState() {
    if (_visible == false) {
      setState(() {
        _visible = true;
        _playAgainIsVisible = !_visible;
        quizBank.nextQuest();
        scoreBoard.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //TODO: Place the scoreBoard in a row widget
        SizedBox(
          child: Row(
            children: scoreBoard,
          ),
          height: 15,
        ),

        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBank.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ),

        Expanded(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  checkAnswerAccurancy(true);
                },
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  checkAnswerAccurancy(false);
                },
                child: Text(
                  'False',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: AnimatedOpacity(
            opacity: !_playAgainIsVisible ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  handlePlayAgainButtonState();
                },
                child: Text(
                  'PLAY AGAIN',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.cyan,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/