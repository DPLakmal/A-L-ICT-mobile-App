import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.dart';

const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late TextEditingController controller;

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    controller = TextEditingController(text: user.displayName);

    controller.addListener(_onNameChanged);

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    log(user.toString());

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onNameChanged);
    super.dispose();
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _onNameChanged() {
    setState(() {
      if (controller.text == user.displayName || controller.text.isEmpty) {
        showSaveButton = false;
      } else {
        showSaveButton = true;
      }
    });
  }

  List get userProviders => user.providerData.map((e) => e.providerId).toList();

  Future updateDisplayName() async {
    await user.updateDisplayName(controller.text);

    setState(() {
      showSaveButton = false;
    });

    if (mounted) {
      ScaffoldSnackbar.of(context).show('Name updated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          maxRadius: 60,
                          backgroundImage: NetworkImage(
                            user.photoURL ?? placeholderImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        alignLabelWithHint: true,
                        label: Center(
                          child: Text(
                            'Click to add a display name',
                          ),
                        ),
                      ),
                    ),
                    Text(user.email ?? user.phoneNumber ?? 'User'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (userProviders.contains('phone'))
                          const Icon(Icons.phone),
                        if (userProviders.contains('password'))
                          const Icon(Icons.mail),
                        if (userProviders.contains('google.com'))
                          SizedBox(
                            width: 24,
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png',
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: _signOut,
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ),
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
