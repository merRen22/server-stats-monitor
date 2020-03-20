import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/styles.dart';
import 'package:server_sync/utils.dart';
import 'package:server_sync/models.dart';
//import 'package:flt_keep/widgets.dart' show AppDrawer, NotesGrid, NotesList;

/// Home screen, displays [Note] grid or list.
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

/// [State] of [HomeScreen].
class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// `true` to show notes in a GridView, a ListView otherwise.
  bool _gridView = true;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
//      statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => null, // watching the note filter
            ),
            Consumer<String>(
              builder: (context, filter, child) => StreamProvider.value(
                value: null, // applying the filter to Firestore query
                child: child,
              ),
            ),
          ],
          child: Consumer2<String, List<String>>(
            builder: (context, filter, notes, child) {
              final hasNotes = notes?.isNotEmpty == true;
              //final canCreate = filter.noteState.canCreate;
              return Scaffold(
                key: _scaffoldKey,
                body: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 720),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _appBar(context, child),
                        if (hasNotes)
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 24),
                          ),
                        ..._buildNotesView(context, notes),
                        if (hasNotes)
                          SliverToBoxAdapter(
                            child: SizedBox(
                                height: (true ? kBottomBarSize : 10.0) + 10.0),
                          ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: true ? _fab(context) : null,
                bottomNavigationBar: true ? _bottomActions() : null,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                extendBody: true,
              );
            },
          ),
        ),
      );

  Widget _appBar(BuildContext context, Widget bottom) => true
      ? SliverAppBar(
          floating: true,
          snap: true,
          title: _topActions(context),
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      : SliverAppBar(
          floating: true,
          snap: true,
          title: Text("Gaaaaaaaaaaa"),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          automaticallyImplyLeading: false,
        );

  Widget _topActions(BuildContext context) => Container(
        // width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 720,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: isNotAndroid ? 7 : 5),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 20),
                InkWell(
                  child: const Icon(Icons.menu),
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Search your notes',
                    softWrap: false,
                    style: TextStyle(
                      color: kHintTextColorLight,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  child: Icon(Icons.list),
                  onTap: () => setState(() {
                    _gridView = !_gridView;
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
              const Icon(Icons.ac_unit, size: 26, color: kIconTintLight),
              const SizedBox(width: 30),
              const Icon(Icons.access_alarm, size: 26, color: kIconTintLight),
              const SizedBox(width: 30),
              const Icon(Icons.accessibility, size: 26, color: kIconTintLight),
              const SizedBox(width: 30),
              const Icon(Icons.account_circle, size: 26, color: kIconTintLight),
            ],
          ),
        ),
      );

  Widget _fab(BuildContext context) => FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          final command = await Navigator.pushNamed(context, '/note');
          debugPrint('--- noteEditor result: $command');
          //processNoteCommand(_scaffoldKey.currentState, command);
        },
      );

  Widget _buildAvatar(BuildContext context) {
    final url = "gaaaaaaaa";
    //Provider.of<CurrentUser>(context)?.data?.photoUrl;
    return CircleAvatar(
      backgroundImage: url != null ? NetworkImage(url) : null,
      child: url == null ? const Icon(Icons.face) : null,
      radius: isNotAndroid ? 19 : 17,
    );
  }

  /// A grid/list view to display notes
  ///
  /// Notes are divided to `Pinned` and `Others` when there's no filter,
  /// and a blank view will be rendered, if no note found.
  List<Widget> _buildNotesView(BuildContext context, List notes) {
    if (notes?.isNotEmpty != true) {
      return [_buildBlankView()];
    }

    final asGrid = true; //filter.noteState == "gaa" || _gridView;
    //final factory = asGrid ? NotesGrid.create : NotesList.create;
    final showPinned = true; //filter.noteState == "gaa2";

    if (!showPinned) {
      return [
        //factory(notes: notes, onTap: () => {}),
      ];
    }

    //final partition = _partitionNotes(notes);
    //final hasPinned = partition.item1.isNotEmpty;
    //final hasUnpinned = partition.item2.isNotEmpty;

    final _buildLabel = (String label, [double top = 26]) => SliverToBoxAdapter(
          child: Container(
            padding:
                EdgeInsetsDirectional.only(start: 26, bottom: 25, top: top),
            child: Text(
              label,
              style: const TextStyle(
                  color: kHintTextColorLight,
                  fontWeight: FontWeights.medium,
                  fontSize: 12),
            ),
          ),
        );

    return [
      //if (hasPinned) _buildLabel('PINNED', 0),
      //if (hasPinned) factory(notes: partition.item1, onTap: _onNoteTap),
      //if (hasPinned && hasUnpinned) _buildLabel('OTHERS'),
      //factory(notes: partition.item2, onTap: () => {}),
    ];
  }

  Widget _buildBlankView() => SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Expanded(flex: 1, child: SizedBox()),
            Icon(
              Icons.featured_play_list,
              size: 120,
              color: kAccentColorLight.shade300,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Gaaaaaaaaa",
                style: TextStyle(
                  color: kHintTextColorLight,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
}

const _10_min_millis = 600000;
