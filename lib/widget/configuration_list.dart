import 'package:flutter/material.dart';

import 'package:server_sync/models.dart' show Configuration;

import 'configuration_item.dart';

import 'package:collection_ext/iterables.dart';

/// ListView for notes
class ConfigurationList extends StatelessWidget {
  final List<Configuration> notes;
  final void Function(Configuration) onTap;

  const ConfigurationList({
    Key key,
    @required this.notes,
    this.onTap,
  }) : super(key: key);

  static ConfigurationList create({
    Key key,
    @required List<Configuration> notes,
    void Function(Configuration) onTap,
  }) => ConfigurationList(
    key: key,
    notes: notes,
    onTap: onTap,
  );

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    sliver: SliverList(
      delegate: SliverChildListDelegate(
        notes.flatMapIndexed((i, note) => <Widget>[
          InkWell(
            onTap: () => onTap?.call(note),
            child: ConfigurationItem(note: note),
          ),
          if (i < notes.length - 1) const SizedBox(height: 10),
        ]).asList(),
      ),
    ),
  );
}