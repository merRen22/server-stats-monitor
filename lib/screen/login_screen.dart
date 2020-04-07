//import 'package:firebase_auth/firebase_auth.dart'show FirebaseAuth, AuthResult, GoogleAuthProvider;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:server_sync/styles.dart';
import 'package:server_sync/screens.dart';
import 'package:server_sync/widgets.dart';

import 'package:server_sync/animations.dart'
    show AnimatedWave, GradientBackGround;

/// Login screen.
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  String _errorMessage;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loggingIn = false;

  void goToAbout() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AboutScreen(),
        ),
      );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final upperWave = AnimatedWave(height: 180, speed: 1.0);

  final middleWave = AnimatedWave(height: 120, speed: 0.9);

  final bottomWave = AnimatedWave(height: 220, speed: 1.2, offset: pi / 2);

  void _signInWithGoogle() async {
    _setLoggingIn(); // show progress
    String errMsg;

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg); // always stop the progress indicator
    }
  }

  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //var userProvider = Provider.of<CurrentUser>(context);

    return Scaffold(
      body: Theme(
          data: ThemeData(primarySwatch: kAccentColorLight).copyWith(
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: kAccentColorLight,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: GradientBackGround(
                  content: SingleChildScrollView(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 560,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 48),
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/images/discord-logo-white.png'),
                          SizedBox(
                            height: 32,
                          ),
                          _loggingIn
                          ?LinearProgressIndicator()
                          :RaisedButton(
                            shape:
                                RoundedRectangleBorder(side: BorderSide.none),
                            padding: const EdgeInsets.all(0),
                            elevation: 0,
                            color: Theme.of(context).accentColor,
                            onPressed: _signInWithGoogle,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/images/google.png',
                                    width: 40),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40 / 1.618),
                                  child: Text("Continue with Google"),
                                )
                              ],
                            ),
                          ),
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onBottom(upperWave),
              onBottom(middleWave),
              onBottom(bottomWave),
              Positioned.fill(
                bottom: 16,
                left: 8,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: buttonContainer(() => goToAbout(), "about"),
                ),
              ),
            ],
          )),
      floatingActionButton: LightManager(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buttonContainer(onAction, label) => RaisedButton(
        elevation: 0,
        color: Theme.of(context).accentColor,
        onPressed: onAction,
        child: Text(label),
      );

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
