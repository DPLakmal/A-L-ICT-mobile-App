import 'package:almcq/views/PastPaper/p_structured.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:almcq/views/PastPaper/p_essay.dart';
import 'package:almcq/views/PastPaper/p_mcq.dart';

// ignore: camel_case_types
class Pastpaper_page extends StatelessWidget {
  const Pastpaper_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            title: const Text(
              "ShortNote",
              textScaleFactor: 2.7,
            ),
            centerTitle: true,
            pinned: false,
            floating: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/quiz-app-9f658.appspot.com/o/make-short-notes-based-on-your-study-notes.jpg?alt=media&token=8de627f3-d55b-49e7-a9ae-261d6cf0a1ba',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  'images/shortnote.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ];
      },
      body: Column(
        children: [
          const Divider(),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "- Lessons Topic -",
                textScaleFactor: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pmcq()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "MCQ",
                        textScaleFactor: 3.5,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PStructured()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "Structured",
                        textScaleFactor: 3.5,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pessay()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "Eassy",
                        textScaleFactor: 3.5,
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
