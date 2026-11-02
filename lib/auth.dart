import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

typedef OAuthSignIn = void Function();

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Helper class to show a snackbar using the passed context.
class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  final BuildContext _context;

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

enum AuthMode { login, register, phone }

/// Entrypoint for sign-in flow with Google.
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String error = '';
  String verificationId = '';

  AuthMode mode = AuthMode.login;
  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100, bottom: 58),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset(
                'assets/1024.png',
                width: 250,
                height: 250,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            Visibility(
              visible: error.isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: MaterialBanner(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(
                    error,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.red)),
                      onPressed: () {
                        setState(() {
                          error = '';
                        });
                      },
                      child: const Text(
                        'dismiss',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                  contentTextStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 280),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.grey,
                        size: 55,
                      )
                    : MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: _signInWithGoogle,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage("assets/google_logo.png"),
                                height: 35.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _signInWithGoogle() async {
    setIsLoading();
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = '${e.message}';
      });
    } catch (e) {
      setState(() {
        error = '$e';
      });
    } finally {
      setIsLoading();
    }
  }
}
