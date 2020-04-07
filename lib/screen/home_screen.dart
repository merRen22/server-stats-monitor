import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/styles.dart';

import 'package:server_sync/models.dart' show CurrentUser, Configuration;
import 'package:server_sync/widgets.dart' show ConfigurationGrid, ConfigurationList;
//import 'package:flt_keep/widgets.dart' show AppDrawer, NotesGrid, NotesList;
import 'package:server_sync/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _gridView = true; // `true` to show a Grid, otherwise a List.

  @override
  Widget build(BuildContext context) => StreamProvider.value(
    value: _createNoteStream(context),
    child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(context), // a floating appbar
          const SliverToBoxAdapter(
            child: SizedBox(height: 24), // top spacing
          ),
          _buildNotesView(context),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80.0), // bottom spacing make sure the content can scroll above the bottom bar
          ),
        ],
      ),
      floatingActionButton: _fab(context),
      bottomNavigationBar: _bottomActions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
    ),
  );

  /// A floating appBar like the one of Google Keep
  Widget _appBar(BuildContext context) => SliverAppBar(
    floating: true,
    snap: true,
    title: _topActions(context),
    automaticallyImplyLeading: false,
    centerTitle: true,
    titleSpacing: 0,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );

  Widget _topActions(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            const Icon(Icons.menu),
            const Expanded(
              child: Text('Search your notes', softWrap: false),
            ),
            InkWell(
              child: Icon(_gridView ? Icons.view_list : Icons.view_module),
              onTap: () => setState(() {
                _gridView = !_gridView; // switch between list and grid style
              }),
            ),
            const SizedBox(width: 18),
            _buildAvatar(context),
            const SizedBox(width: 10),
          ],
        ),
      ),
    ),
  );

  Widget _bottomActions() => BottomAppBar(
    shape: const CircularNotchedRectangle(),
    child: Container(
      height: kBottomBarSize,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: <Widget>[
          Text("Aca habran iconos")
        ],
      ),
    ),
  );

  Widget _fab(BuildContext context) => FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () =>{});

  Widget _buildAvatar(BuildContext context) {
    final url = Provider.of<CurrentUser>(context)?.data?.photoUrl;

    return GestureDetector(
      onTap: () async {
        final command = await Navigator.pushNamed(context, '/note');
        //processNoteCommand(_scaffoldKey.currentState, command);
      },
      child: GestureDetector(
        onTap: () => Application.router.navigateTo(context, "/user", 
      //transition: transitionType
      ),
        child: CircleAvatar(
          backgroundImage: url != null ? NetworkImage(url) : null,
          child: url == null ? const Icon(Icons.face) : null,
          radius: 17,
        ),
      ),
    );
  }

  /// A grid/list view to display notes
  Widget _buildNotesView(BuildContext context) => Consumer<List<Configuration>>(
    builder: (context, notes, _) {
      if (notes?.isNotEmpty != true) {
        return _buildBlankView();
      }

      final widget = _gridView ? ConfigurationGrid.create : ConfigurationList.create;
      return widget(notes: notes, onTap: (_) {});
    },
  );

  Widget _buildBlankView() => const SliverFillRemaining(
    hasScrollBody: false,
    child: Text('Notes you add appear here',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
    ),
  );

  /// Create the notes query
  Stream<List<Configuration>> _createNoteStream(BuildContext context) {
    final uid = Provider.of<CurrentUser>(context)?.data?.uid;
    return Firestore.instance.collection('configurations-$uid')
      //.where('state', isEqualTo: 0)
      .snapshots()
      .handleError((e) => debugPrint('query notes failed: $e'))
      .map((snapshot) => Configuration.fromQuery(snapshot));
  }
}