import 'package:almcq/views/mcq/mcq_lessons_play.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Mcq_Lessons_Select extends StatelessWidget {
  final String year;
  final String quizId;
  const Mcq_Lessons_Select({Key? key, required this.year, required this.quizId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> dashlist = <String>[
      'Concpet of ICT',
      'Computer History',
      'Number System',
      'Logic Gates',
      'Database Management',
      'Programming',
      'Web Development',
      'Internet Of Things',
      'Operating Systems',
      'System Analysis & Design',
      'ICT In Business',
      'Networking'
    ];

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 200,
              title: Text(
                "$year MCQ Lessons select ",
                textScaleFactor: 1,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              pinned: true,
              floating: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              )),
        ];
      },
      body: Center(
        child: ListView.builder(
            itemCount: dashlist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  color: Colors.white,
                  elevation: 10,
                  height: 70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(58),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPlay(
                                  title: year,
                                  quizId: quizId,
                                  tag: dashlist[index],
                                )));
                  },
                  child: Text(dashlist[index]),
                ),
              );
            }),
      ),
    ));
  }
}
