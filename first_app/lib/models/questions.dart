class Quizquestion {
  const Quizquestion(this.text, this.answers);
  final String text;
  final List<String> answers;

  List<String> getSuffleAnswers() {
    final ShuffleList = List.of(answers);
    ShuffleList.shuffle();
    return ShuffleList;
  }
}
