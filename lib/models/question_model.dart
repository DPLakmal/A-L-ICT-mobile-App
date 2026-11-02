// ignore_for_file: non_constant_identifier_names

class QuestionModel {
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? option5;
  String? correctOption;
  String? image;
  String? explanning_image;
  String? quizNumber;
  String? correct_answer;
  String? tag;
  bool? answered;

  QuestionModel({
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    this.correctOption,
    this.image,
    this.explanning_image,
    this.quizNumber,
    this.correct_answer,
    this.tag,
    this.answered = false,
  });
}
