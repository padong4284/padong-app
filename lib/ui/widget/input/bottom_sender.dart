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
import 'package:padong/util/padong/padong.dart';

const Map<BottomSenderType, String> _hints = {
  BottomSenderType.ARGUE: "Argue",
  BottomSenderType.REPLY: "Reply",
  BottomSenderType.REVIEW: "Review",
  BottomSenderType.CHAT: "Message",
  BottomSenderType.SEARCH: "Search",
};

class BottomSender extends StatefulWidget {
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

  _BottomSenderState createState() => _BottomSenderState();
}

class _BottomSenderState extends State<BottomSender>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool startAnimate = true;
  String before = '';
  Padong padong = Padong(
      100, List.generate(3, (_) => AppTheme.colors.primary.withAlpha(100)));

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PadongBottomBar(
          withAnonym: widget.type == BottomSenderType.REPLY,
          withStars: widget.type == BottomSenderType.REVIEW,
          child: Container(
              padding: EdgeInsets.only(
                  left: widget.type == BottomSenderType.CHAT
                      ? AppTheme.horizontalPadding + 20
                      : 0),
              child: Input(
                hintText: widget.hintText,
                isMultiline: widget.type != BottomSenderType.SEARCH,
                icon: widget.icon,
                toNext: widget.afterHide,
                controller: widget.msgController,
                onPressIcon: widget.onSubmit,
                focus: widget.focus,
                onChanged: widget.onChange ??
                    (widget.type == BottomSenderType.SEARCH
                        ? (curr) {
                            if (curr.isNotEmpty &&
                                curr.length != this.before.length)
                              this.padong.onKeyPressed(curr[curr.length - 1]);
                            this.before = curr;
                          }
                        : null),
              ))),
      widget.type == BottomSenderType.SEARCH
          ? this.keyboardWave()
          : SizedBox.shrink(),
      widget.type == BottomSenderType.CHAT
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
      widget.chatImage(imageURL);
    });
  }

  Widget keyboardWave() {
    return Container(
          transform: Matrix4.translationValues(0.0, -140.0, 0.0),
          height: 50,
          child: CustomPaint(
              painter: PadongPainter(this.padong), child: Container()),
        );
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == BottomSenderType.SEARCH) {
      this._controller =
          AnimationController(duration: Duration(seconds: 5), vsync: this);
      this.animation = CurvedAnimation(
          parent: this._controller, // using controller, not this.controller
          curve: Curves.bounceInOut);
      this.animation.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          this._controller.reverse();
        else if (status == AnimationStatus.dismissed)
          this._controller.forward();
      });

      this.animation.addListener(() {
        if (this.startAnimate) {
          this.startAnimate = false;
          this.animate();
        }
      });
      this._controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.type == BottomSenderType.SEARCH)
      this._controller.dispose(); // finish animation
    super.dispose(); // due to lifecycle, call after controller disposed
  }

  void animate() async {
    await Future.delayed(Duration(milliseconds: 20));
    if (mounted) setState(() => this.padong.update());
    this.startAnimate = true;
  }
}
