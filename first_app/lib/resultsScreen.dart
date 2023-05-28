import 'package:first_app/data/questions.dart';
import 'package:first_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/questions_summary.dart';
import 'package:first_app/QnScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_app/startscreen.dart';
import 'package:first_app/quiz.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> Summary = [];
    for (var i = 0; i < questions.length; i++) {
      Summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return Summary;
  }

  @override
  Widget build(BuildContext context) {
    final SummaryData = getSummaryData();
    final Total = questions.length;
    final correct = SummaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'You answered $correct out of $Total correctly',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 159, 152, 27),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                QuestionSummary(data: SummaryData),
                const SizedBox(height: 20),
                // TextButton(
                //   onPressed: () {},
                //   child: Text("restart Quiz!!",

                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.lato(
                //         color: Color.fromARGB(255, 159, 152, 27),
                //         fontSize: 24,
                //         fontWeight: FontWeight.bold,
                //       )),
                // )
              ],
            )),
        OutlinedButton.icon(
            onPressed: () {
              ;
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 162, 52, 52),
            ),
            label: const Text("Restart Quiz!!"),
            icon: const Icon(Icons.loop)),
      ],
    );
  }
}
