import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';
import 'package:padong/ui/widgets/cards/summary_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/containers/swipe_deck.dart';
import 'package:padong/ui/widgets/univ_door.dart';
import 'package:padong/core/apis/session.dart' as Session;

class CoverView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> cover;

  CoverView()
      : this.id = Session.currentUniv['coverId'],
        this.cover = getCoverAPI(Session.currentUniv['coverId']);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          onPressAdd: () {
            PadongRouter.routeURL('edit?id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      title: 'Wiki',
      children: [
        UnivDoor(),
        this.emblemArea(),
        SizedBox(height: 30),
        SwipeDeck(
            children: this
                .cover['fixedWikis']
                .values
                .map((wikiId) => SummaryCard(wikiId))
                .toList()),
        Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 5),
            child: Text('Recently Edited',
                style: AppTheme.getFont(
                    fontSize: AppTheme.fontSizes.mlarge, isBold: true))),
        HorizontalScroller(
            padding: 3.0,
            children: get10RecentWikiIdsAPI(this.id)
                .map((wikiId) => PhotoCard(wikiId, isWiki: true))
                .toList()),
        SizedBox(height: 40),
      ],
    );
  }

  Widget emblemArea() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ]),
              child: CircleAvatar(
                  radius: 32,
                  backgroundColor: AppTheme.colors.transparent,
                  backgroundImage: this.cover['emblem'] != null
                      ? NetworkImage(this.cover['emblem'])
                      : null)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.place_rounded,
                  color: AppTheme.colors.primary, size: 30)),
          Text(this.cover['loc'], style: AppTheme.getFont())
        ]));
  }
}
