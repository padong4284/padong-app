import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/dialogs/image_uploader.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

const Map<BottomSenderType, String> hints = {
  BottomSenderType.ARGUE: "Argue",
  BottomSenderType.REPLY: "Reply",
  BottomSenderType.REVIEW: "Review",
  BottomSenderType.CHAT: "Message"
};

class BottomSender extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final BottomSenderType type;
  final TextEditingController msgController;

  BottomSender(BottomSenderType senderType, {this.msgController})
      : this.hintText = hints[senderType],
        this.icon = Icon(
            BottomSenderType.ARGUE == senderType ? Icons.add : Icons.send,
            color: AppTheme.colors.primary,
            size: 24),
        this.type = senderType;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FloatingBottomBar(
          withAnonym: this.type == BottomSenderType.REPLY,
          withStars: this.type == BottomSenderType.REVIEW,
          child: Container(
              padding: EdgeInsets.only(
                  left: this.type == BottomSenderType.CHAT
                      ? AppTheme.horizontalPadding + 20
                      : 0),
              child: Input(
                  hintText: this.hintText,
                  isMultiline: true,
                  icon: this.icon,
                  toNext: false,
                  controller: this.msgController))),
      this.type == BottomSenderType.CHAT
          ? Container(
              // Image Uploader
              margin: const EdgeInsets.only(
                  left: AppTheme.horizontalPadding - 2, top: 7),
              child: IconButton(
                  onPressed:
                      this.addPhoto(context), // TODO: get user's attachment
                  icon: Icon(Icons.photo_camera_rounded,
                      size: 30, color: AppTheme.colors.support)))
          : SizedBox.shrink()
    ]);
  }

  Function addPhoto(context) {
    return getImageFromUser(context, (PickedFile image) {
      // https://github.com/ptyagicodecamp/flutter_cookbook/blob/widgets/flutter_widgets/lib/images/upload_image.dart
      // TODO: upload to firebase
      this.msgController.text = image.path; // TODO: send img to chatroom
    });
  }
}
