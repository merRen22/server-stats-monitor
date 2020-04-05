import 'package:cloud_firestore/cloud_firestore.dart';

class Configuration {
  final String id;
  String key;
  ConfigurationState state;
  final DateTime createdAt;
  DateTime modifiedAt;

  /// Instantiates a [Configuration].
  Configuration({
    this.id,
    this.key,
    DateTime createdAt,
    DateTime modifiedAt,
  }) : this.createdAt = createdAt ?? DateTime.now(),
    this.modifiedAt = modifiedAt ?? DateTime.now();

  /// Transforms the Firestore query [snapshot] into a list of [Note] instances.
  static List<Configuration> fromQuery(QuerySnapshot snapshot) => snapshot != null ? toConfigurations(snapshot) : [];
}

/// State enum for a note.
enum ConfigurationState {
  empty,
  incomplete,
  completed,
}

/// Transforms the query result into a configuration instance.
List<Configuration> toConfigurations(QuerySnapshot query) => query.documents
  .map((d) => toNote(d))
  .where((n) => n != null)
  .toList();

/// Transforms a document into a single note.
Configuration toNote(DocumentSnapshot doc) => doc.exists
  ? Configuration(
    id: doc.documentID,
    key: doc.data['key'],
    //state: NoteState.values[doc.data['state'] ?? 0],
    createdAt: DateTime.fromMillisecondsSinceEpoch(doc.data['createdAt'] ?? 0),
    modifiedAt: DateTime.fromMillisecondsSinceEpoch(doc.data['modifiedAt'] ?? 0),
  )
  : null;

//Color _parseColor(num colorInt) => Color(colorInt ?? 0xFFFFFFFF);