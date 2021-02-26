import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/tiles/notice_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

import 'package:padong/core/apis/deck.dart';

class BoardView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> board;

  BoardView(id)
      : this.id = id,
        this.board = getBoardAPI(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongFloatingButton(isScrollingDown: isScrollingDown),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Write', onTap: () {}, isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.board['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {})
      ]),
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.0, top: 10.0),
          alignment: Alignment.centerLeft,
          child: Text(this.board['description'],
              style: TextStyle(color: AppTheme.colors.semiSupport)),
        ),
        Container(
            padding: EdgeInsets.only(bottom: 41.0), child: NoticeTile('123')),
        Column(
          children: [
            TitleHeader('Posts'),
            PostTile('123'),
            PostTile('123'),
            PostTile('123'),
            PostTile('123'),
            PostTile('123'),
          ],
        )
      ],
    ));
  }
}
