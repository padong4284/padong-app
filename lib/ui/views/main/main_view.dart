import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

import 'package:padong/ui/widgets/cards/post_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/cards/event_card.dart';
import 'package:padong/ui/widgets/tiles/notice_tile.dart';
import 'package:padong/ui/widgets/tiles/node_tile.dart';

class MainView extends StatelessWidget {
  final bool isPMain;

  MainView({this.isPMain = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildTopBar(),
        body: SafePaddingTemplate(
            child: Column(
          children: [
            NodeTile(id: '0321'),
            NodeTile(id: '0321', noProfile: true,),
            NodeTile(id: '0321', noProfile: true, noBottom: true,),
            NodeTile(id: '0321', isReply: true),
            NodeTile(id: '0321', isReReply: true),
            NoticeTile(notices: [
              'You must read this',
              'You must click this',
              'You must read this',
              'You must click this'
            ]),
            EventCard('1234',
                timeRange: '00:00 ~ 24:00',
                date: '03/21/2021',
                infos: {'Periodicity': 'Annual', 'Alerts': '00:00, 12:00'}),
            EventCard(
              '1234',
              timeRange: '13:30 ~ 15:45',
              rate: 4.5,
              infos: {
                'Professor': 'Daewoong Ko',
                'Room': 'Klaus 402',
                'Grade': 'Absolute'
              },
              isToReview: true,
            ),
            TabContainer(tabWidth: 80.0, tabs: [
              'Popular',
              'Favorite',
              'Inform',
            ], children: [
              HorizontalScroller(
                  padding: 3.0,
                  children: Iterable<int>.generate(10)
                      .map((idx) => PostCard(idx.toString()))
                      .toList()),
              SwipeDeck(children: [
                SummaryCard('1', title: 'Title1'),
                SummaryCard('2', title: 'Title2'),
                SummaryCard('3', title: 'Title3')
              ]),
              HorizontalScroller(
                  padding: 3.0,
                  parentLeftPadding: 25.0,
                  parentRightPadding: 25.0,
                  children: Iterable<int>.generate(10)
                      .map((idx) => PostCard(idx.toString()))
                      .toList()),
            ]),
            BoardListTile(
                boards: ['Global', 'Public', 'Internal'],
                icons: [Icons.cloud, Icons.public, Icons.badge]),
            BoardListTile(boards: [
              'Algorithm',
              'Computer Architecture',
              'Data Structure',
              'System Programming',
              'Philosophy'
            ], isAlertTile: true),
            BoardListTile(boards: [
              'Replied',
              'Liked',
              'Saved'
            ], icons: [
              Icons.mode_comment,
              Icons.favorite_rounded,
              Icons.bookmark_rounded
            ]),
          ],
        )),
    );
  }
  AppBar _buildTopBar() {
    return AppBar(
      brightness: Brightness.light,
      // when dark mode, using dark
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
        visible: !this.isPMain,
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
