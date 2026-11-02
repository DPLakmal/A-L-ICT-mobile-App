import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../services/admob.dart';
import 'mcq_lessons.dart';
import 'mcq_year.dart';

// ignore: camel_case_types
class mcq extends StatelessWidget {
  const mcq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              title: const Text(
                "Quiz",
                textScaleFactor: 1.5,
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
                  background: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://firebasestorage.googleapis.com/v0/b/quiz-app-9f658.appspot.com/o/More%2Fa-levels-test-696x464.png?alt=media&token=77c7c1da-4b07-430e-bb22-3de2b1c64e8a",
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Image.asset(
                        'images/mcq.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
            ),
          ];
        },
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "- MCQ Quiz Options -",
              textScaleFactor: 1.5,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.white,
                    minWidth: 175,
                    height: 400,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mcq_Lessons()));
                    },
                    child: const Center(
                      child: Text(
                        "Catergized \n Lessons ",
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    minWidth: 175,
                    height: 400,
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mcq_Year()));
                    },
                    child: const Center(
                        child: Text(
                      "MCQ via \n    Year ",
                      textScaleFactor: 1.5,
                    )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdmobService.createBannerAd()..load(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
