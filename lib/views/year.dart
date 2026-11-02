import 'package:almcq/views/quiz_play.dart';
import 'package:flutter/material.dart';

class Mcq_Year extends StatelessWidget {
  const Mcq_Year({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> dashlist = <String>[
      'two-one',
      'two-zero',
      'one-nine',
      'one-eight',
      'one-seven',
      'one-six',
      'one-five',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Main Menu")),
      body: Center(
        child: ListView.builder(
            itemCount: dashlist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const QuizPlay("JxEc91kikfXAFx1VqAWN")));
                    }
                    if (index == 1) {
                      //2020
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const QuizPlay("7cKYH7YIOJfLXVRg")));
                    }
                    if (index == 2) {
                      //2019
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const QuizPlay("0036767856232765")));
                    }
                    if (index == 3) {
                      //2018
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const QuizPlay("BRVM2u42YNRO555D")));
                    }
                  },
                  child: Material(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(58),
                    ),
                    child: Image.asset(
                      "images/${dashlist[index]}.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
