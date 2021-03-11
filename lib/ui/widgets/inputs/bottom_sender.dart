///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
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
  final Function onSubmit;
  final TextEditingController msgController;
  final bool afterHide;
  final FocusNode focus;

  BottomSender(BottomSenderType senderType,
      {@required this.onSubmit,
      this.msgController,
      this.focus,
      this.afterHide = false})
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
                toNext: this.afterHide,
                controller: this.msgController,
                onPressIcon: this.onSubmit,
                focus: this.focus,
              ))),
      this.type == BottomSenderType.CHAT
          ? Container(
              // Image Uploader
              margin: const EdgeInsets.only(
                  left: AppTheme.horizontalPadding - 2, top: 7),
              child: IconButton(
                  onPressed: this.addPhotoFunction(context),
                  icon: Icon(Icons.photo_camera_rounded,
                      size: 30, color: AppTheme.colors.support)))
          : SizedBox.shrink()
    ]);
  }

  Function addPhotoFunction(context) {
    return getImageFromUser(context, (PickedFile image) {
      // https://github.com/ptyagicodecamp/flutter_cookbook/blob/widgets/flutter_widgets/lib/images/upload_image.dart
      // TODO: upload to firebase
      this.msgController.text = image.path; // TODO: send img to chatroom
    });
  }
}
