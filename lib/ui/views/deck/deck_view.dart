import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widgets/top_boards.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

class DeckView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> deck;
  final pipBoards = ['Global', 'Public', 'Internal'];

  DeckView()
      : this.id = Session.currentUniv['deckId'],
        this.deck = getDeckAPI(Session.currentUniv['deckId']);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          onPressAdd: () {
            PadongRouter.routeURL('make?id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      title: 'Deck',
      children: [
        SizedBox(height: 10),
        TopBoards(this.deck['id']),
        SizedBox(height: 10),
        BoardListTile(
          boardIds: this
              .pipBoards
              .map(
                  (boardName) => this.deck['fixedBoards'][boardName].toString())
              .toList(),
          icons: [Icons.cloud, Icons.public, Icons.badge],
        ),
        BoardListTile(
          boardIds: this.deck['boards'],
          isAlertTile: true,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
