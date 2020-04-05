import 'package:flutter/material.dart';

import 'package:server_sync/models.dart' show Configuration;

import 'configuration_item.dart';

/// Grid view of [Note]s.
class ConfigurationGrid extends StatelessWidget {
  final List<Configuration> notes;
  final void Function(Configuration) onTap;

  const ConfigurationGrid({
    Key key,
    @required this.notes,
    this.onTap,
  }) : super(key: key);

  static ConfigurationGrid create({
    Key key,
    @required List<Configuration> notes,
    void Function(Configuration) onTap,
  }) => ConfigurationGrid(
    key: key,
    notes: notes,
    onTap: onTap,
  );

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1 / 1.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => _noteItem(context, notes[index]),
        childCount: notes.length,
      ),
    ),
  );

  Widget _noteItem(BuildContext context, Configuration note) => InkWell(
    onTap: () => onTap?.call(note),
    child: ConfigurationItem(note: note),
  );
}