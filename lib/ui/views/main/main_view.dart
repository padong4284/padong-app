import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

import 'package:padong/ui/widgets/cards/post_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/univ_door.dart';

class MainView extends StatelessWidget {
  final bool isPMain;

  MainView({this.isPMain = false});

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: _buildTopBar(),
      children: [
        UnivDoor(univName: 'Georgia Tech', slogan: 'Progress and Service'),
        SizedBox(height: 35),
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
              children: Iterable<int>.generate(10)
                  .map((idx) => PostCard(idx.toString()))
                  .toList()),
        ]),
        BoardListTile(
            boards: ['Global', 'Public', 'Internal'],
            icons: [Icons.cloud, Icons.public, Icons.badge]),
      ],
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
          padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
          alignment: Alignment.center,
          child: Text('PADONG',
              style: AppTheme.getFont(
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
