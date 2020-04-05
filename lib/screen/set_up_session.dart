import 'package:flutter/material.dart';

class SessionSetUp extends StatefulWidget {
  SessionSetUp({Key key}) : super(key: key);

  @override
  _SessionSetUpState createState() => _SessionSetUpState();
}

class _SessionSetUpState extends State<SessionSetUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
         child: Text("Setting up"),
      ),
    );
  }
}