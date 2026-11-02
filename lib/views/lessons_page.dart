// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Lessons_Page extends StatelessWidget {
  Lessons_Page({Key? key}) : super(key: key);
  final controller = ScrollController();
  final List<String> Lesson_list = <String>[
    'mcq',
    'structured',
    'essay',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "- Lessons Topic -",
                textScaleFactor: 1.5,
              ),
            ),
            ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: Lesson_list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          // Navigator.push(context,
                          //           MaterialPageRoute(builder: (context) => Mcq_Year()));
                        }
                      },
                      child: Material(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(58),
                        ),
                        child: Image.asset(
                          "images/${Lesson_list[index]}.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
