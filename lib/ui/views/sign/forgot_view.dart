import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/shared/dialog_callback.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/cards/lecture_card.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/containers/back_app_bar.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(buttons: [
        ToggleIconButton(
            defaultIcon: Icons.favorite_outline_rounded,
            toggleIcon: Icons.favorite_rounded,
            toggleColor: AppTheme.colors.pointRed),
      ToggleIconButton(
          defaultIcon: Icons.bookmark_outline_rounded,
          toggleIcon: Icons.bookmark_rounded,
          onPressed: dialogCallback(context, 'Bookmark', 'Add page to bookmarks!'),)
      ]),
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
