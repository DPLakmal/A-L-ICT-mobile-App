import 'package:almcq/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/quiz_play_widgets.dart';

class QuizPlay extends StatefulWidget {
  final String quizId;
  const QuizPlay(this.quizId, {Key? key}) : super(key: key);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _QuizPlayState extends State<QuizPlay> {
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot? questionSnaphot;
  bool isLoading = false;

  @override
  void initState() {
    databaseService.getQuestionyearData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot!.docs.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot!.docs.length;
      setState(() {});
    });

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();

    questionModel.question = questionSnapshot.get("question");

    try {
      questionModel.image = questionSnapshot.get("image");
    } catch (_) {
      questionModel.image = null;
    }

    List<String> options = [
      questionSnapshot.get("option1"),
      questionSnapshot.get("option2"),
      questionSnapshot.get("option3"),
      questionSnapshot.get("option4"),
      questionSnapshot.get("option5")
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.option5 = options[4];
    questionModel.correctOption = questionSnapshot.get("option1");
    questionModel.answered = false;

    return questionModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz Play"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      questionSnaphot?.docs == null
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 300),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              itemCount: questionSnaphot!.docs.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: QuizPlayTile(
                                      questionModel:
                                          getQuestionModelFromDatasnapshot(
                                              questionSnaphot!.docs[index]),
                                      index: index,
                                    ),
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const QuizPlayTile(
      {Key? key, required this.questionModel, required this.index})
      : super(key: key);

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Question  ${widget.index + 1} ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 22, color: Colors.black.withOpacity(0.8)),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 56, 53, 53),
            ),
            Text(
              " ${widget.questionModel.question}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
            if (widget.questionModel.image != null &&
                widget.questionModel.image!.isNotEmpty &&
                (widget.questionModel.image!.startsWith('http://') ||
                    widget.questionModel.image!.startsWith('https://')))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  widget.questionModel.image!,
                  errorBuilder: (context, error, stackTrace) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                ),
              )
            else
              const SizedBox()
          ],
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered!) {
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option1!;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option1!;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "i",
            description: "${widget.questionModel.option1}",
            correctAnswer: widget.questionModel.correctOption!,
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered!) {
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option2!;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option2!;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "ii",
            description: "${widget.questionModel.option2}",
            correctAnswer: widget.questionModel.correctOption!,
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered!) {
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option3!;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option3!;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "iii",
            description: "${widget.questionModel.option3}",
            correctAnswer: widget.questionModel.correctOption!,
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered!) {
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option4!;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option4!;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "iv",
            description: "${widget.questionModel.option4}",
            correctAnswer: widget.questionModel.correctOption!,
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered!) {
              if (widget.questionModel.option5 ==
                  widget.questionModel.correctOption) {
                setState(() {
                  optionSelected = widget.questionModel.option5!;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                });
              } else {
                setState(() {
                  optionSelected = widget.questionModel.option5!;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                });
              }
            }
          },
          child: OptionTile(
            option: "v",
            description: "${widget.questionModel.option5}",
            correctAnswer: widget.questionModel.correctOption!,
            optionSelected: optionSelected,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Color.fromARGB(255, 56, 53, 53),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Correct Answer :"),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("${widget.questionModel.correctOption ?? ''}"),
                            ],
                          )),
                        ),
                      );
                    });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "විවරණය",
                  textScaleFactor: 1.5,
                ),
              )),
        ))
      ],
    );
  }
}
