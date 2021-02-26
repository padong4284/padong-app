import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
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
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Write', onTap: () {}, isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.board['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {})
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: PadongMarkdown(this.board['description']),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: NoticeTile(this.id)),
        TitleHeader('Posts'),
        ...getPostIdsAPI(this.id).map((postId) => PostTile(postId))
      ],
    ));
  }
}
