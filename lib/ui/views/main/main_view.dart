import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/bars/top_app_bar.dart';
import 'package:padong/ui/widgets/cards/building_card.dart';
import 'package:padong/ui/widgets/cards/question_card.dart';
import 'package:padong/ui/widgets/cards/timelines/timeline_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/containers/vertical_timeline.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/top_boards.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/univ_door.dart';
import 'package:padong/core/apis/session.dart' as Session;

class MainView extends StatelessWidget {
  final bool isPMain;
  final Map<String, dynamic> univ;

  MainView({this.isPMain = false}) : this.univ = Session.currentUniv;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: TopAppBar('PADONG'),
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongFloatingButton(isScrollingDown: isScrollingDown),
      children: [
        UnivDoor(),
        SizedBox(height: 35),
        TopBoards(this.univ['deckId']),
        ...this.questionArea(),
        ...this.eventsArea(),
        ...this.placesArea(),
        ...this.padongArea(),
      ],
    );
  }

  List<Widget> questionArea() {
    return [
      this._title('Questions'),
      SizedBox(height: 10),
      SwipeDeck(children: List.generate(5, (i) => QuestionCard('$i')))
      // TODO: more button
    ];
  }

  List<Widget> eventsArea() {
    // TODO: more button
    return [
      this._title('Events in ${TimeManager.thisMonth()}'),
      VerticalTimeline(
          dots: List.generate(5, (i) => '3/2$i'),
          cards: List.generate(5, (_) => [TimelineCard(getEventAPI('123'))]),
          hideTopDate: true)
    ];
  }

  List<Widget> placesArea() {
    return [
      this._title('Places'),
      HorizontalScroller(
          height: 150,
          children: [
            ...List.generate(10, (idx) => BuildingCard(idx.toString()))
          ],
          moreId: '123')
    ];
  }

  List<Widget> padongArea() {
    return [
      this._title('PADONG'),
      BoardListTile(
          boardIds: ['freeTalk', 'questionAnswer', 'inform'],
          isAlertTile: true),
      Text('Contact Us'),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('Copyright 2021. PADONG. All rights reserved.',
              style: AppTheme.getFont(
                  color: AppTheme.colors.semiSupport,
                  fontSize: AppTheme.fontSizes.small))),
    ];
  }

  Widget _title(String title) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 5),
        child: Text(title,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge, isBold: true)));
  }
}
