import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
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
      FloatingBottomBar(
          withAnonym: widget.type == BottomSenderType.REPLY,
          withStars: widget.type == BottomSenderType.REVIEW,
          child: Container(
              padding: EdgeInsets.only(
                  left: widget.type == BottomSenderType.CHAT
                      ? AppTheme.horizontalPadding + 20
                      : 0),
              child: Input(
                  hintText: widget.hintText,
                  isMultiline: true,
                  icon: widget.icon,
                  toNext: false,
                  onChanged: (String msg) {
                    setState(() {
                      this.message = msg;
                    });
                  }))),
      widget.type == BottomSenderType.CHAT
          ? Container(
              margin: const EdgeInsets.only(
                  left: AppTheme.horizontalPadding, top: 8),
              child: IconButton(
                  onPressed: () {}, // TODO: get user's attachment
                  icon: Icon(Icons.photo_camera_rounded,
                      size: 30, color: AppTheme.colors.support)))
          : SizedBox.shrink()
    ]);
  }
}
