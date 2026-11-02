import 'package:almcq/services/admob.dart';
import 'package:almcq/views/mcq/mcq.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> dashlist = <String>[
  'mcq',
  'structured',
  'essay',
];

// ignore: camel_case_types
class Quiz_page extends StatefulWidget {
  const Quiz_page({Key? key}) : super(key: key);

  @override
  State<Quiz_page> createState() => _Quiz_pageState();
}

// ignore: camel_case_types
class _Quiz_pageState extends State<Quiz_page> {
  bool isLoading = true;

  void loadData() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1600), () {
      loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(167, 164, 164, 0.373),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdmobService.createBannerAd()..load(),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('DashBoard_Images')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.horizontalRotatingDots(
                            color: Colors.white,
                            size: 100,
                          ),
                        ],
                      ),
                    );
                  }
                  List<Widget> sliderItems = [];
                  for (var document in snapshot.data!.docs) {
                    final data = document.data() as Map<String, dynamic>?;
                    final url = data != null && data.containsKey('a')
                        ? data['a'] as String?
                        : null;
                    if (url != null && url.isNotEmpty) {
                      sliderItems.add(
                        CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'images/1024.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                  if (sliderItems.isEmpty) {
                    sliderItems.add(
                      Image.asset(
                        'images/1024.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: ImageSlideshow(
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        onPageChanged: (value) {},
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: sliderItems,
                      ),
                    ),
                  );
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                      'Spefical Notic',
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  return Column(
                    children: snapshot.data!.docs.map((document) {
                      final data = document.data() as Map<String, dynamic>?;
                      if (data != null && data['message'] != null) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            elevation: 15,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "*  Special Notice  *",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      data['message'],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (data["link"] != null &&
                                      data["buttonName"] != null)
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor),
                                      ),
                                      onPressed: () {
                                        launchUrl(
                                            Uri.parse(data['link']));
                                      },
                                      child: Text(data['buttonName']),
                                    ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                  );
                }),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdmobService.createBannerAd()..load(),
              ),
            ),
            const Divider(),
            const Center(
              child: Text(
                "- Paper Quiz Type -",
                textScaleFactor: 1.5,
              ),
            ),
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: dashlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const mcq()));
                        }
                      },
                      child: Material(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: Image.asset(
                          "images/${dashlist[index]}.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdmobService.createBannerAd()..load(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
