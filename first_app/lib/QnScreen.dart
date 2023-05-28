import 'package:first_app/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:first_app/answerbutton.dart';
import 'package:first_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onselectanswer});
  final void Function(String answer) onselectanswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreen();
  }
}

class _QuestionsScreen extends State<QuestionsScreen> {
  var QuestionIndex = 0;
  void answerquestion(String SelectedAnswer) {
    widget.onselectanswer(SelectedAnswer);
    setState(() {
      QuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final qn = questions[QuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                textAlign: TextAlign.center,
                qn.text,
                style: GoogleFonts.lato(
                  color: Color.fromARGB(255, 159, 152, 27),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            ...qn.getSuffleAnswers().map(
              (option) {
                return Answerbutton(
                    optiontext: option,
                    ontap: () {
                      answerquestion(option);
                    });
              },
            ),
            // Answerbutton(qn.answers[0], () {}),
            // const SizedBox(
            //   height: 10,
            // ),
            // Answerbutton(qn.answers[1], () {}),
            // const SizedBox(
            //   height: 10,
            // ),
            // Answerbutton(qn.answers[2], () {}),
            // const SizedBox(
            //   height: 10,
            // ),
            // Answerbutton(qn.answers[3], () {}),
          ],
        ),
      ),
    );
  }
}
