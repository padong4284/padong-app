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
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';
import 'package:padong/ui/widget/dialog/image_uploader.dart';
import 'package:padong/ui/widget/input/input.dart';

const Map<BottomSenderType, String> _hints = {
  BottomSenderType.ARGUE: "Argue",
  BottomSenderType.REPLY: "Reply",
  BottomSenderType.REVIEW: "Review",
  BottomSenderType.CHAT: "Message",
  BottomSenderType.SEARCH: "Search",
};

class BottomSender extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final BottomSenderType type;
  final Function onSubmit;
  final Function(String img) chatImage;
  final Function(String curr) onChange;
  final TextEditingController msgController;
  final bool afterHide;
  final FocusNode focus;

  BottomSender(BottomSenderType senderType,
      {@required this.onSubmit,
      this.msgController,
      this.focus,
      this.chatImage,
      this.onChange,
      this.afterHide = false})
      : assert((senderType != BottomSenderType.CHAT) || (chatImage != null)),
        this.hintText = _hints[senderType],
        this.icon = Icon(
            senderType == BottomSenderType.ARGUE
                ? Icons.add
                : senderType == BottomSenderType.SEARCH
                    ? Icons.search_rounded
                    : Icons.send,
            color: AppTheme.colors.primary,
            size: 24),
        this.type = senderType;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PadongBottomBar(
          withAnonym: this.type == BottomSenderType.REPLY,
          withStars: this.type == BottomSenderType.REVIEW,
          child: Container(
              padding: EdgeInsets.only(
                  left: this.type == BottomSenderType.CHAT
                      ? AppTheme.horizontalPadding + 20
                      : 0),
              child: Input(
                hintText: this.hintText,
                isMultiline: this.type != BottomSenderType.SEARCH,
                icon: this.icon,
                toNext: this.afterHide,
                controller: this.msgController,
                onPressIcon: this.onSubmit,
                focus: this.focus,
                onChanged: this.onChange,
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
    return ImageUploader.getImageFromUser(context, (String imageURL) {
      this.chatImage(imageURL);
    });
  }
}
