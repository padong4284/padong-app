import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widgets/bars/padong_bottom_navigation_bar.dart';
import 'package:padong/ui/views/cover/wiki_cover_view.dart';
import 'package:padong/ui/views/deck/deck_view.dart';
import 'package:padong/ui/views/map/map_view.dart';
import 'package:padong/ui/views/schedule/schedule_view.dart';
import 'package:padong/ui/views/main/main_view.dart';

final List<Widget> pages = [
  MainView(),
  WikiCoverView(),
  DeckView(),
  ScheduleView(),
  MapView(),
];

class RouteView extends StatefulWidget {
  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    PadongRouter.registerContext(this.context);
    return Scaffold(
        bottomNavigationBar: PadongBottomNavigationBar(
            selectedIdx: _selectedIdx,
            setSelectedIdx: (int idx) => setState(() {
                  this._selectedIdx = idx;
                })),
        body: pages[this._selectedIdx]);
  }
}
