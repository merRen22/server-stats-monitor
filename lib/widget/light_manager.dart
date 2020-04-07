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

    aux.color = theme.color;
    aux.label = theme.label;

    return aux;
  }

  Future changeTheme(index,themeProvider, selectedColor) async {
    themeProvider.toggleTheme(index);

    await controller.forward().whenComplete(() => controller.reverse());
  }

  void buildColorselector(themeProvider) =>
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select your theme color",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8, 
                children: appColors.asMap().map(
                      (index,color) => MapEntry(
                        index,GestureDetector(
                        onTap: () => changeTheme(index,themeProvider,color),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: color.color),
                          child: SizedBox(
                            height: 35,
                            width: 35,
                          ),
                        ),
                      )),
                    ).values.toList()
                    ),
          )
        ]);
      },
    );

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context);

    var themeValues = toggleData(themeProvider.selectedThemeColor);

    return GestureDetector(
      onTap: () => buildColorselector(themeProvider),
      child: Stack(alignment: Alignment.center, children: <Widget>[
        animatedLabel(themeValues),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 5, color: Theme.of(context).buttonColor),
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle),
            child: FaIcon(FontAwesomeIcons.tint),
          ),
        ),
      ]),
    );
  }

  Widget animatedLabel(themeValues) {
    final tween = Tween(begin: Offset(0, 0), end: Offset(40, 0));

    final animation = tween.animate(controller);

    final decoration = BoxDecoration(
      color: themeValues.color,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(8, 10, 40, 10),
        child: Text(themeValues.label),
      ),
      builder: (animatorContext, child) {
        return Transform.translate(offset: animation.value, child: child);
      },
    );
  }
}
