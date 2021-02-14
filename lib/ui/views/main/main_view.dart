import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/post_card.dart';
import 'package:padong/ui/widgets/horizontal_scroller.dart';

import 'package:padong/ui/widgets/bottom_navigation_bar.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

import 'package:padong/ui/widgets/summary_card.dart';
import 'package:padong/ui/widgets/swipe_deck.dart';
import 'package:padong/ui/widgets/tab_container.dart';
import 'package:padong/ui/widgets/switch_button.dart';

class MainView extends StatefulWidget {
  final bool isPMain;

  MainView({this.isPMain = false});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildTopBar(),
        body: SafePaddingTemplate(
            child: Column(
          children: [
            HorizontalScroller(
                padding: 3.0,
                parentLeftPadding: 25.0,
                parentRightPadding: 25.0,
                children: Iterable<int>.generate(10)
                    .map((idx) => PostCard(idx.toString()))
                    .toList()),
            TabContainer(tabs: [
              'Scroll',
              'Swipe'
            ], children: [
              HorizontalScroller(
                  padding: 3.0,
                  parentLeftPadding: 20.0,
                  parentRightPadding: 20.0,
                  children: Iterable<int>.generate(10)
                      .map((idx) => PostCard(idx.toString()))
                      .toList()),
              SwipeDeck(children: [
                SummaryCard('1', title: 'Title1'),
                SummaryCard('2', title: 'Title2'),
                SummaryCard('3', title: 'Title3')
              ])
            ]),
          ],
        )),
        bottomNavigationBar: PadongBottomNavigationBar());
  }

  AppBar _buildTopBar() {
    return AppBar(
      brightness: Brightness.light, // when dark mode, using dark
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Visibility(
        child: Container(
          padding: EdgeInsets.only(left: 25.0),
          alignment: Alignment.center,
          child: Text('PADONG',
              style: TextStyle(
                  fontSize: AppTheme.fontSizes.large,
                  color: AppTheme.colors.semiPrimary)),
        ),
        visible: !widget.isPMain,
      ),
      leadingWidth: 110.0,
      actions: [
        SizedBox(
            width: 32.0,
            child: IconButton(
                icon:
                    Icon(Icons.mode_comment, color: AppTheme.colors.support))),
        SizedBox(
            width: 32.0,
            child: IconButton(
                icon: Icon(Icons.account_circle,
                    color: AppTheme.colors.support))),
        SizedBox(width: 25.0)
      ],
    );
  }
}
