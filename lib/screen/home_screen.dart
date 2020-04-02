import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/styles.dart';
import 'package:server_sync/utils.dart';
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
              //final canCreate = filter.noteState.canCreate;
              return Scaffold(
                key: _scaffoldKey,
                body: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 720),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _appBar(context, child),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                extendBody: true,
              );
            },
          ),
        ),
      );

  Widget _appBar(BuildContext context, Widget bottom) => 
  SliverAppBar(
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
}
