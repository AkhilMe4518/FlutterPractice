import 'package:flutter/material.dart';
import 'package:first_app/quiz.dart';
import 'package:first_app/startscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              'assets/logo.png',
              width: 300,
              color: Color.fromARGB(255, 210, 43, 43),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Test your knowledge of Genshin',
            style: GoogleFonts.lato(
                color: Color.fromARGB(255, 159, 152, 27),
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
              onPressed: startQuiz,
              style: OutlinedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 162, 52, 52),
              ),
              label: const Text("Start Quiz"),
              icon: const Icon(Icons.access_alarm_sharp))
        ],
      ),
    );
  }
}
