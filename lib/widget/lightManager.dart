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

class _LightManagerState extends State<LightManager> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
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

    aux.color = Theme.of(context).buttonColor;

    if (theme) {
      aux.label = "Light ";
      aux.icon = FontAwesomeIcons.sun;

      return aux;
    }

    aux.label = "Dark ";
    aux.icon = FontAwesomeIcons.moon;

    return aux;
  }

  Future changeTheme(themeProvider) async {
    themeProvider.toggleSunny();

    await controller.forward().whenComplete(() => controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context);

    var themeValues = toggleData(themeProvider.sunny);

    return GestureDetector(
      onTap: () => changeTheme(themeProvider),
      child: Stack(
        alignment: Alignment.center, 
        children: <Widget>[
          animatedLabel(themeValues),
          Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Theme.of(context).buttonColor),
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
                  child: FaIcon(themeValues.icon)
                  )
          ),
      ]),
    );
  }

  Widget animatedLabel(themeValues) {
    final animation = Tween(begin: Offset(0, 0), end: Offset(40, 0)).animate(controller);

    final decoration  = BoxDecoration(
              color: themeValues.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)
              )
    );

    return AnimatedBuilder(
        animation: animation,
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.fromLTRB(8, 10, 45, 10),
          child: Text(themeValues.label),
        ),
        builder: (animatorContext, child) {
          return Transform.translate(offset: animation.value, child: child);
        });
  }
}
