import 'package:flutter/material.dart';
import 'package:server_sync/models.dart' show Configuration;
//import 'package:flt_keep/styles.dart';

/// A single item (preview of a Note) in the Notes list.
class ConfigurationItem extends StatelessWidget {
  const ConfigurationItem({
    Key key,
    this.note,
  }) : super(key: key);

  final Configuration note;

  @override
  Widget build(BuildContext context) => Hero(
    tag: 'NoteItem${note.id}',
    child: DefaultTextStyle(
      style: TextStyle(),//kNoteTextLight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,//note.color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          //border: note.color.value == 0xFFFFFFFF ? Border.all(color: kBorderColorLight) : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(note.key,
              //style: kCardTitleLight,
              maxLines: 1,
            ),
            /*
            if (note.title?.isNotEmpty == true) Text(note.title,
              style: kCardTitleLight,
              maxLines: 1,
            ),
            */
            //if (note.title?.isNotEmpty == true) const SizedBox(height: 14),
            /*
            Flexible(
              flex: 1,
              child: Text(note.content ?? ''), // wrapping using a Flexible to avoid overflow
            ),
            */
          ],
        ),
      ),
    ),
  );
}