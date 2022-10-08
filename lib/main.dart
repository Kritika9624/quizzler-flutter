import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizBrain.dart';

QuizBrain qb = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAns(bool userPickedAns) {
    // bool correctAns = qb.getAnswer();
    // qb.getNextQues();
    // if (correctAns == userPickedAns) {
    //   scoreKeeper.add(
    //     Icon(
    //       Icons.check,
    //       color: Colors.green,
    //     ),
    //   );
    // } else {
    //   scoreKeeper.add(
    //     Icon(
    //       Icons.close,
    //       color: Colors.red,
    //     ),
    //   );
    // }
    bool correctAnswer = qb.getCorrectAnswer();

    setState(() {
      if (qb.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        qb.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAns == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        qb.getNextQues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
        SizedBox(
          height: 26,
          // width: 250,
          // child: Divider(
          //   color: Colors.blue.shade300,
          // ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 0),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(4.0),
            // ),
          ),
          child: Text(
            'True',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              backgroundColor: Colors.green,
            ),
          ),
          onPressed: () {
            setState(() {
              checkAns(true);
            });
          },
        ),
        SizedBox(
          height: 26,
          // width: 250,
          // child: Divider(
          //   color: Colors.blue.shade300,
          // ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 0),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(4.0),
            // ),
          ),
          child: Text(
            'False',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            //The user picked false.
            setState(() {
              checkAns(false);
            });
          },
        ),
      ],
    );
  }
}
