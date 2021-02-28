import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/event_card.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/deck.dart';

class EventView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> event;

  EventView(id)
      : this.id = id,
        this.event = getEventAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Memo',
          onTap: () {
            PadongRouter.routeURL('memo/id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.event['title'], actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Text(this.event['description'], style: AppTheme.getFont()),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: EventCard(this.id)),
        TitleHeader('Memos'),
        ...getPostIdsAPI(this.id).map((postId) => PostTile(postId))
      ],
    );
  }
}
