import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class GradientBackGround extends StatelessWidget {
  final Widget content;

  GradientBackGround({this.content});

  static final lightColor = Track("color1").add(
    Duration(seconds: 3),
    ColorTween(
      begin: Color(0xff3c00ff),
      end: Color(0xff7145FF),
    ),
  );

  static final darkColor = Track("color2").add(
    Duration(seconds: 3),
    ColorTween(
      begin: Color(0xff2700A3),
      end: Color(0xff7145FF),
    ),
  );

  final tween = MultiTrackTween([lightColor, darkColor]);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [animation["color1"], animation["color2"]],
              ),
            ),
            child: this.content);
      },
    );
  }
}
