import 'package:first_app/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:first_app/startscreen.dart';
import 'package:first_app/QnScreen.dart';
import 'package:first_app/quiz.dart';
import 'package:first_app/resultsScreen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchscreen);
    super.initState();
  }

  void switchscreen() {
    setState(() {
      selectedAnswers = [];
      activeScreen = QuestionsScreen(
        onselectanswer: chooseAnswer,
      );
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(chosenAnswers: selectedAnswers);
      });
    }
  }

  void restartquiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = QuestionsScreen(onselectanswer: chooseAnswer);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(210, 149, 42, 36),
              Color.fromARGB(255, 7, 1, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
