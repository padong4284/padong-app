import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/containers/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/containers/tip_container.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

const Map<BottomSenderType, String> hints = {
  BottomSenderType.ARGUE: "Argue",
  BottomSenderType.REPLY: "Reply",
  BottomSenderType.REVIEW: "Review",
  BottomSenderType.CHAT: "Message"
};

class BottomSender extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final BottomSenderType type;

  BottomSender(BottomSenderType senderType)
      : this.hintText = hints[senderType],
        this.icon = Icon(
            BottomSenderType.ARGUE == senderType ? Icons.add : Icons.send,
            color: AppTheme.colors.primary,
            size: 24),
        this.type = senderType;

  @override
  _BottomSenderState createState() => _BottomSenderState();
}

class _BottomSenderState extends State<BottomSender> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 45),
          child: FloatingBottomBar(
              child: Container(
                  padding: EdgeInsets.only(
                      left: widget.type == BottomSenderType.CHAT
                          ? AppTheme.horizontalPadding + 20
                          : 0),
                  child: Input(
                      hintText: widget.hintText,
                      isMultiline: true,
                      icon: widget.icon,
                      onChanged: (String msg) {
                        setState(() {
                          this.message = msg;
                        });
                      })))),
      widget.type == BottomSenderType.ARGUE ||
              widget.type == BottomSenderType.CHAT
          ? SizedBox.shrink()
          : this.getTip(),
      widget.type == BottomSenderType.CHAT
          ? Container(
              margin: const EdgeInsets.only(
                  left: AppTheme.horizontalPadding, top: 52),
              child: IconButton(
                  onPressed: () {}, // TODO: get user's attachment
                  icon: Icon(Icons.photo_camera,
                      size: 30, color: AppTheme.colors.support)))
          : SizedBox.shrink()
    ]);
  }

  Widget getTip() { // TODO: handling input from tip
    return Container(
        padding:
            const EdgeInsets.only(left: AppTheme.horizontalPadding, bottom: 56),
        child: widget.type == BottomSenderType.REVIEW
            ? TipContainer(
                width: 180,
                child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 3.5),
                    child: StarRateButton(rate: 0.0)))
            : SwitchButton(
                options: ['anonym', 'profile'],
                buttonType: SwitchButtonType.TOOLTIP));
  }
}
