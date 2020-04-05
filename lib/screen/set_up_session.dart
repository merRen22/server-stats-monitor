import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SkeletonAnimation(
              child: Container(
                width: 150,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(height: 32),
            SkeletonAnimation(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SkeletonAnimation(
        child: Container(
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        ),
      ),
    );
  }
}
