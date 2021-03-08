import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/deck.dart';

class BuildingView extends StatelessWidget {
  final String id;
  final bool readOnly =
  false; // TODO: PIP / Written, Replied, Liked, Bookmarked
  final Map<String, dynamic> board;

  BuildingView(id)
      : this.id = id,
        this.board = getBoardAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: !this.readOnly
          ? (isScrollingDown) => FloatingBottomButton(
          title: 'Serve',
          onTap: () {
            PadongRouter.routeURL('/serve?id=${this.id}');
          },
          isScrollingDown: isScrollingDown)
          : null,
      appBar: BackAppBar(title: this.board['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: PadongMarkdown(this.board['description']),
        ),
        TitleHeader('Posts'),
        ...getPostIdsAPI(this.id).map((postId) => PostTile(postId))
      ],
    );
  }
}
