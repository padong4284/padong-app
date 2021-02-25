import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/post_card.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';

class DeckView extends StatelessWidget {
  final String univId;
  final Map<String, dynamic> univ;
  final fixedBoards = [
    'Popular',
    'Favorite',
    'Inform',
  ];

  DeckView(univId)
      : this.univId = univId,
        this.univ = getUnivAPI(univId);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          onPressAdd: () {}, isScrollingDown: isScrollingDown),
      title: 'Deck',
      children: [
        TabContainer(
            tabWidth: 80.0,
            tabs: this.fixedBoards,
            children: this.fixedBoards.map((boardName) {
              String boardId = this.univ['fixedBoards'][boardName];
              List<String> recent10s = get10RecentPostIdsAPI(boardId);
              return HorizontalScroller(
                  padding: 3.0,
                  children:
                      recent10s.map((postId) => PostCard(postId)).toList());
            }).toList()),
        Container(
          height: 60.0,
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 10.0),
          child: TranspButton(
            title: 'More',
            buttonSize: ButtonSize.REGULAR,
            icon: Icon(Icons.arrow_forward_ios,
                color: AppTheme.colors.primary,
                size: AppTheme.fontSizes.regular),
            isSuffixICon: true,
          ),
        ),
        BoardListTile(
          boardIds: ['Global', 'Public', 'Internal']
              .map(
                  (boardName) => this.univ['fixedBoards'][boardName].toString())
              .toList(),
          icons: [Icons.cloud, Icons.public, Icons.badge],
        ),
        BoardListTile(
          boardIds: this.univ['boards'],
          isAlertTile: true,
        )
      ],
    );
  }
}
