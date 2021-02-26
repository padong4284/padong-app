import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/views/deck/top_boards.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

class DeckView extends StatelessWidget {
  final Map<String, dynamic> univ;
  final PIPBoards = [
    'Global', 'Public', 'Internal'
  ];

  DeckView()
      : this.univ = getUnivAPI(Session.user['univId']);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          onPressAdd: () {}, isScrollingDown: isScrollingDown),
      title: 'Deck',
      children: [
        SizedBox(height: 10),
        TopBoards(this.univ),
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
