import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/padong_bottom_navigation_bar.dart';

import 'package:padong/ui/views/cover/wiki_cover_view.dart';
import 'package:padong/ui/views/deck/deck_view.dart';
import 'package:padong/ui/views/map/map_view.dart';
import 'package:padong/ui/views/schedule/schedule_view.dart';
import 'package:padong/ui/views/main/main_view.dart';

class RouteView extends StatefulWidget {

  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GlobalKey<NavigatorState>> _navigatorKeys = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>()
    ];
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
          !await _navigatorKeys[_selectedIndex].currentState.maybePop();

          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4)
          ],
        ),
        bottomNavigationBar: PadongBottomNavigationBar(
            selectedIndex: _selectedIndex,
            setSelectedIndex: (int index) => setState(() {this._selectedIndex = index;})
        )
      )
    );
  }
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          MainView(),
          WikiCoverView(),
          DeckView(),
          ScheduleView(),
          MapView(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
