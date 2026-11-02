import 'package:almcq/views/mcq/mcq_lessons_select.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Mcq_Lessons extends StatelessWidget {
  const Mcq_Lessons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> dashlist = <String>[
      'JxEc91kikfXAFx1VqAWN',
      '7cKYH7YIOJfLXVRg',
      '0036767856232765',
      'BRVM2u42YNRO555D',
      'one-seven',
      'one-six',
      'one-five',
    ];

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 200,
                title: const Text("Catergized Lessons"),
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
        body: ListView.builder(
            itemCount: dashlist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  color: Colors.white,
                  elevation: 10,
                  height: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(58),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mcq_Lessons_Select(
                                  quizId: dashlist[index],
                                  year: '${2021 - index}',
                                )));
                  },
                  child: Text("${2021 - index} MCQ Category Lessons List"),
                ),
              );
            }),
      ),
    );
  }
}
