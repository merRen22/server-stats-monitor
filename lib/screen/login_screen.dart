//import 'package:firebase_auth/firebase_auth.dart'show FirebaseAuth, AuthResult, GoogleAuthProvider;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:server_sync/styles.dart';
import 'package:server_sync/widgets.dart';
import 'package:simple_animations/simple_animations.dart';

/// Login screen.
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

/// State for [LoginScreen].
class _LoginScreenState extends State<LoginScreen> {
  //final _auth = FirebaseAuth.instance;

  final _loginForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loggingIn = false;
  String _errorMessage;
  bool _useEmailSignIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final tween = MultiTrackTween([
    Track("color1").add(Duration(seconds: 3),
        ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
    Track("color2").add(Duration(seconds: 3),
        ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
  ]);

  @override
  Widget build(BuildContext context) => Scaffold(
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
                    child: ControlledAnimation(
                        playback: Playback.MIRROR,
                        tween: tween,
                        duration: tween.duration,
                        builder: (context, animation) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  animation["color1"],
                                  animation["color2"]
                                ])),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _loginForm,
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                        'assets/images/discord-logo-white.png'),
                                    const SizedBox(height: 32),
                                    const Text(
                                      'MC - Sync',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeights.medium,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    if (!_useEmailSignIn)
                                      ..._buildGoogleSignInFields(),
                                    if (_errorMessage != null)
                                      _buildLoginMessage(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                onBottom(AnimatedWave(
                  height: 180,
                  speed: 1.0,
                )),
                onBottom(AnimatedWave(
                  height: 120,
                  speed: 0.9,
                  offset: pi,
                )),
                onBottom(AnimatedWave(
                  height: 220,
                  speed: 1.2,
                  offset: pi / 2,
                )),
              ],
            )),
        floatingActionButton: LightManager(),
      );

  List<Widget> _buildGoogleSignInFields() => [
        RaisedButton(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          onPressed: _signInWithGoogle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset('assets/images/discord-logo-white.png', width: 40),
              SizedBox(width: 8),
              Text('Continue with Discord'),
            ],
          ),
        ),
        if (_loggingIn)
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 12),
            child: const CircularProgressIndicator(),
          ),
      ];

  List<Widget> _buildEmailSignInFields() => [
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'Email',
          ),
          validator: (value) =>
              value.isEmpty ? 'Please input your email' : null,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          validator: (value) =>
              value.isEmpty ? 'Please input your password' : null,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        _buildEmailSignInButton(),
        if (_loggingIn) const LinearProgressIndicator(),
        FlatButton(
          child: Text('Use Google Sign In'),
          onPressed: () => setState(() {
            _useEmailSignIn = false;
          }),
        ),
      ];

  Widget _buildEmailSignInButton() => RaisedButton(
        onPressed: _signInWithEmail,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: const Text('Sign in / Sign up'),
        ),
      );

  Widget _buildLoginMessage() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 18),
        child: Text(
          _errorMessage,
          style: const TextStyle(
            fontSize: 14,
            color: kErrorColorLight,
          ),
        ),
      );

  void _signInWithGoogle() async {
    _setLoggingIn();
    String errMsg;

    try {
      //final googleUser = await _googleSignIn.signIn();
      //final googleAuth = await googleUser.authentication;
      /*
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      */
      //await _auth.signInWithCredential(credential);
    } catch (e, s) {
      debugPrint('google signIn failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  void _signInWithEmail() async {
    if (_loginForm.currentState?.validate() != true) return;

    FocusScope.of(context).unfocus();
    String errMsg;
    try {
      _setLoggingIn();
      final result = "gaa";
      //await _doEmailSignIn(_emailController.text, _passwordController.text);
      debugPrint('Login result: $result');
    } on PlatformException catch (e) {
      errMsg = e.message;
    } catch (e, s) {
      debugPrint('login failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

/*
  Future<AuthResult> _doEmailSignIn(String email, String password,
          {bool signUp = false}) =>
      (signUp
              ? _auth.createUserWithEmailAndPassword(
                  email: email, password: password)
              : _auth.signInWithEmailAndPassword(
                  email: email, password: password))
          .catchError((e) {
        if (e is PlatformException && e.code == 'ERROR_USER_NOT_FOUND') {
          return _doEmailSignIn(email, password, signUp: true);
        } else {
          throw e;
        }
      });
*/
  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
