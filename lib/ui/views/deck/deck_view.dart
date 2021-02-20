import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/cards/post_card.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/shared/push_callbacks.dart' as pushCallbacks;

class DeckView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongFloatingButton(
              onPressAdd: () {}, isScrollingDown: isScrollingDown),
      title: 'Deck',
      children: [
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
          SwipeDeck(
              children: [SummaryCard('1'), SummaryCard('2'), SummaryCard('3')]),
          HorizontalScroller(
              padding: 3.0,
              children: Iterable<int>.generate(10)
                  .map((idx) => PostCard(idx.toString()))
                  .toList()),
        ]),
        Container(
          height: 69.0,
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 5.0, right: 16.0),
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
          boardIds: ['0', '1', '2'],
          icons: [Icons.cloud, Icons.public, Icons.badge],
        )
      ],
    );
  }

  Function _registeredPushNamed(String id) {
    return () => pushCallbacks.registeredPushNamed("/board/id=$id");
  }
}
