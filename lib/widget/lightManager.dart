import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/models.dart';

class LightManager extends StatefulWidget {
  @override
  _LightManagerState createState() => _LightManagerState();
}

class FabData {
  String label;
  IconData icon;
  Color color;
}

class _LightManagerState extends State<LightManager>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  FabData toggleData(theme) {
    FabData aux = FabData();

    if (theme) {
      aux.label = "Light ";
      aux.icon = FontAwesomeIcons.sun;
      aux.color = Color(0xFF59F8E8);

      return aux;
    }

    aux.label = "Dark ";
    aux.icon = FontAwesomeIcons.moon;
    aux.color = Color(0xFF03191E);

    return aux;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context);

    var themeValues = toggleData(themeProvider.sunny);

    return GestureDetector(
      onTap: () {
        themeProvider.toggleSunny();
        controller.reverse().whenComplete(() => controller.forward());
      },
      child: Stack(alignment: Alignment.center, children: <Widget>[
        animatedLabel(themeValues),
        Positioned(
            right: 0,
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    color: Color(0xFF23272A),
                    shape: BoxShape.circle),
                child: FaIcon(themeValues.icon))),
      ]),
    );
  }

  Widget animatedLabel(themeValues) {
    final animation =
        Tween(begin: Offset(60, 0), end: Offset(0, 0)).animate(controller);

    return AnimatedBuilder(
        animation: animation,
        child: Container(
          decoration: BoxDecoration(
              color: themeValues.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
          padding: const EdgeInsets.fromLTRB(8, 5, 48, 5),
          margin: const EdgeInsets.fromLTRB(8, 10, 0, 10),
          child: Text(themeValues.label),
        ),
        builder: (animatorContext, child) {
          return Transform.translate(offset: animation.value, child: child);
        });
  }
}
