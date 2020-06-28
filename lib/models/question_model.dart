class Question {
  String question;
  Map<String, String> options;
  String correctAnswer;

  Question() {
    // question = data['question'];
    // // options = data['options'];
    // correctAnswer = data['correct'];
    question = "How many function keys can you access on a keyboard ?";
    options = {"a": "12", "b": "16", "c": "24", "d": "22"};
    correctAnswer = "24";
  }

  // Question({this.question, this.options, this.correctAnswer});

}
