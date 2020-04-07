import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class GradientBackGround extends StatelessWidget {
  final Widget content;

  GradientBackGround({this.content});

  @override
  Widget build(BuildContext context) {

    final lightColor = Track("color1").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Theme.of(context).primaryColor.withOpacity(0.4),
        end: Theme.of(context).primaryColor.withOpacity(0.7),
      ),
    );

    final darkColor = Track("color2").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Theme.of(context).primaryColor.withOpacity(0.8),
        end: Theme.of(context).primaryColor.withOpacity(0.3),
      ),
    );

    final tween = MultiTrackTween([lightColor, darkColor]);

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
