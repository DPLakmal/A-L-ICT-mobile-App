import 'package:flutter/material.dart';

import '../../services/admob.dart';
import 'mcq_year_play.dart';

// ignore: camel_case_types
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
      appBar: AppBar(title: const Text("MCQ via Year")),
      bottomNavigationBar: SizedBox(
        height: 100,
        width: double.infinity,
        child: AdWidget(
          key: UniqueKey(),
          ad: AdmobService.createBannerAd()..load(),
        ),
      ),
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
                              builder: (context) => QuizPlay(
                                    iscategories: false,
                                    quizId: "JxEc91kikfXAFx1VqAWN",
                                    title: '2021',
                                  )));
                    }
                    if (index == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPlay(
                                    quizId: "7cKYH7YIOJfLXVRg",
                                    iscategories: false,
                                    title: '2020',
                                  )));
                    }
                    if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPlay(
                                    quizId: "0036767856232765",
                                    iscategories: false,
                                    title: '2019',
                                  )));
                    }
                    if (index == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPlay(
                                    quizId: "BRVM2u42YNRO555D",
                                    iscategories: false,
                                    title: '2018',
                                  )));
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
