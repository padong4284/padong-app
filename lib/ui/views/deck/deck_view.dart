import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/cards/post_card.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';

class DeckView extends StatelessWidget {
  final String univId;
  final Map<String, dynamic> univ;
  final topBoards = [
    'Popular', 'Favorite', 'Inform'
  ];
  final PIPBoards = [
    'Global', 'Public', 'Internal'
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
        SizedBox(height: 10),
        TabContainer(
            tabWidth: 80.0,
            tabs: this.topBoards,
            moreIds: this.topBoards.map(
                    (boardName) => this.univ['fixedBoards'][boardName].toString()).toList(),
            children: this.topBoards.map((boardName) {
              List<String> recent = get10RecentPostIdsAPI(
                  this.univ['fixedBoards'][boardName]);
              return HorizontalScroller(
                  padding: 3.0,
                  children: recent.map((postId) => PostCard(postId)).toList());
            }).toList()),
        SizedBox(height: 10),
        BoardListTile(
          boardIds: this.PIPBoards
              .map(
                  (boardName) => this.univ['fixedBoards'][boardName].toString())
              .toList(),
          icons: [Icons.cloud, Icons.public, Icons.badge],
        ),
        BoardListTile(
          boardIds: this.univ['boards'],
          isAlertTile: true,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
