import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/shared/dialog_callback.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/inputs/times/date_time_range_picker.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: BackAppBar(
          switchButton: SwitchButton(
            options: ['write', 'prev'],
          ),
          actions: [
            ToggleIconButton(
                defaultIcon: Icons.favorite_outline_rounded,
                toggleIcon: Icons.favorite_rounded),
            ToggleIconButton(
              defaultIcon: Icons.bookmark_outline_rounded,
              toggleIcon: Icons.bookmark_rounded,
              onPressed:
                  dialogCallback(context, 'Bookmark', 'Add page to bookmarks!'),
            )
          ]),
      children: [
        DateTimeRangePicker(minuteGap: 5),
      ],
      floatingBottomBar: BottomSender(BottomSenderType.CHAT),
    );
  }
}
