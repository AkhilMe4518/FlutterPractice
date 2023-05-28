import 'package:flutter/material.dart';

class Answerbutton extends StatelessWidget {
  const Answerbutton(
      {super.key, required this.optiontext, required this.ontap});
  final String optiontext;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(204, 190, 192, 81),
            backgroundColor: Color.fromARGB(198, 82, 7, 7),
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        onPressed: ontap,
        child: Text(
          optiontext,
          textAlign: TextAlign.center,
        ));
  }
}
