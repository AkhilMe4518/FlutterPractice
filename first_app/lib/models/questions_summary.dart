import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  QuestionSummary({super.key, required this.data});
  List<Map<String, Object>> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: data.map((data) {
            return Row(children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.lime),
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      data['question'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 159, 152, 27),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['user_answer'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 159, 152, 27),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['correct_answer'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 159, 152, 27),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
