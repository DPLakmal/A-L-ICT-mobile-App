import 'package:almcq/views/lessons_page.dart';
import 'package:almcq/views/pastpaper_page.dart';
import 'package:almcq/views/quiz_page.dart';
import 'package:almcq/views/shortnote_page.dart';
import '../widgets/bubble_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/exit.dart';

late int currentIndex;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentPage = 0;
  final _pageController = PageController();

  String? photoURL;

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showExitPopup(context);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          title: const Text("Smartify - AL ICT"),
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 128, 125, 125),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_on_outlined)),
            GestureDetector(
              child: CircleAvatar(
                radius: 18,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: user!.photoURL!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                        )
                      : const Icon(Icons.person),
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (user?.photoURL != null)
                                  CircleAvatar(
                                    maxRadius: 60,
                                    backgroundImage: CachedNetworkImageProvider(
                                      '${user!.photoURL}',
                                    ),
                                  )
                                else
                                  const CircleAvatar(
                                    maxRadius: 60,
                                    child: Icon(Icons.person, size: 60),
                                  ),
                                const SizedBox(height: 20),
                                Text("${user?.displayName ?? 'User'}"),
                                const SizedBox(height: 10),
                                Text("${user?.email ?? ''}"),
                                const SizedBox(height: 40),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    _signOut();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sign out'),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            const Quiz_page(),
            Lessons_Page(),
            const ShortNote_Page(),
            const Pastpaper_page()
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: _currentPage,
          onTap: (index) {
            _pageController.jumpToPage(index!);
            setState(() => _currentPage = index);
          },
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          hasInk: true,
          inkColor: Colors.black12,
          items: const <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
                title: Text("Quiz ")),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.play_lesson,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.play_lesson,
                  color: Colors.deepPurple,
                ),
                title: Text("Lessons ")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  Icons.note_alt,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.note_alt,
                  color: Colors.indigo,
                ),
                title: Text("Short Notes")),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.folder,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.folder,
                  color: Colors.green,
                ),
                title: Text("Past Papers "))
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
