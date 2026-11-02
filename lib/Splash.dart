import 'dart:async';
import 'package:almcq/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'views/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  void startSplashScreenTimer() {
    const duration = Duration(seconds: 2);
    _timer = Timer(duration, navigateToPage);
  }

  void navigateToPage() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const DashBoard();
              }
              return const AuthGate();
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/powered_by.png',
                  height: 35.0,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              Image.asset(
                'assets/1024.png',
                width: 250,
                height: 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
