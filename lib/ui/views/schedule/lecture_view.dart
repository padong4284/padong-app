import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/cards/lecture_card.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/tiles/notice_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/deck.dart';

class LectureView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> lecture;

  LectureView(id)
      : this.id = id,
        this.lecture = getLectureAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Ask',
          onTap: () {
            PadongRouter.routeURL('ask/id=${this.id}');
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: this.lecture['title'], actions: [
        IconButton(
            icon: Icon(Icons.mode_comment_outlined,
                color: AppTheme.colors.support),
            onPressed: () {}), // TODO: route to chat
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {
              PadongRouter.routeURL(
                  '/update/id=${this.lecture['parentId']}&lectureId=${this.id}');
            }) // TODO: more dialog
      ]),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Text(this.lecture['description'], style: AppTheme.getFont()),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: LectureCard(this.id, isToReview: true)),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: NoticeTile(this.id)),
        TitleHeader('Q&A'),
        ...getPostIdsAPI(this.id).map((postId) => PostTile(postId))
      ],
    );
  }
}
