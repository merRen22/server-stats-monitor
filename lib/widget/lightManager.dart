import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:server_sync/styles.dart';

class LightManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FloatingActionButton(
      key: UniqueKey(),
      backgroundColor: kAccentColorLight,
      child: Icon(
        Icons.wb_sunny,
        color: kWarnColorLight,
      ),
      onPressed: () => {});
}
