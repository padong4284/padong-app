import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/shared/dialog_callback.dart';
import 'package:padong/ui/widgets/cards/lecture_card.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/containers/back_app_bar.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(
        buttonIcons: [Icons.favorite_outline_rounded, Icons.bookmark_outline_rounded],
        buttonCallbacks: [
          dialogCallback(context, 'Likes', 'Add to Likes'),
          dialogCallback(context, 'Bookmarks', 'Bookmark this page')
        ],
      ),
      children: [
        LectureCard('1234'),
        LectureCard('1234'),
        LectureCard('1234'),
        LectureCard('1234'),
        LectureCard('1234'),
        LectureCard('1234')
      ],
      floatingBottomBar: BottomSender(BottomSenderType.CHAT),
    );
  }
}
