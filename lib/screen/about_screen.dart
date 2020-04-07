import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text("Page on work"),
        ),
    );
  }
}
