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
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/statistics.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';

class BackAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final List<Widget> actions;
  final SwitchButton switchButton;
  final bool isClose;
  final Widget bottom;
  final Statistics likeAndBookmark;
  static Function(int idx) updateLikeBookmark;

  BackAppBar(
      {Key key,
      this.title,
      this.switchButton,
      this.likeAndBookmark,
      this.actions,
      this.isClose = false,
      bottom})
      : preferredSize =
            Size.fromHeight(kToolbarHeight + (bottom != null ? 40.0 : 0.0)),
        assert(title == null || switchButton == null),
        assert(likeAndBookmark == null || actions == null),
        this.bottom = bottom,
        super(key: key);

  _BackAppBarState createState() => _BackAppBarState();
}

class _BackAppBarState extends State<BackAppBar> {
  List<bool> likeBookmark;

  @override
  void initState() {
    super.initState();
    if (widget.likeAndBookmark != null) {
      this.likeBookmark = [
        widget.likeAndBookmark.isLiked(Session.user),
        widget.likeAndBookmark.isBookmarked(Session.user)
      ];
      BackAppBar.updateLikeBookmark = (int idx) =>
          setState(() => this.likeBookmark[idx] = !this.likeBookmark[idx]);
    }
  }

  @override
  void dispose() {
    BackAppBar.updateLikeBookmark = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // when dark mode, using dark
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widget.switchButton != null
            ? widget.switchButton
            : widget.title != null
                ? Text(widget.title,
                    textAlign: TextAlign.center,
                    style: AppTheme.getFont(
                        color: AppTheme.colors.fontPalette[0],
                        fontSize: AppTheme.fontSizes.large))
                : null,
        centerTitle: true,
        leading: Padding(
            padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
            child: SimpleButton('', buttonSize: ButtonSize.LARGE, onTap: () {
              Navigator.pop(context);
            },
                icon: Icon(
                    widget.isClose ? Icons.close : Icons.arrow_back_ios_rounded,
                    size: 25))),
        leadingWidth: 25 + AppTheme.horizontalPadding,
        actions: [
          ...(widget.likeAndBookmark != null
              ? this._likeAndBookmarkActions()
              : []),
          ...(widget.actions ?? []).map((button) => Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: button is Button ? 67 : 32,
                child: button,
              ))),
          SizedBox(width: AppTheme.horizontalPadding)
        ],
        bottom: widget.bottom != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: widget.bottom,
              )
            : null);
  }

  List<Widget> _likeAndBookmarkActions() {
    return [
      ToggleIconButton(Icons.favorite_outline_rounded,
          toggleIcon: Icons.favorite_rounded,
          isToggled: this.likeBookmark[0], onPressed: () async {
        await widget.likeAndBookmark.updateLiked(Session.user);
        if (BottomButtons.update != null) BottomButtons.update(0);
        setState(() {
          this.likeBookmark[0] = !this.likeBookmark[0];
        });
      }, initEveryTime: true),
      ToggleIconButton(Icons.bookmark_outline_rounded,
          toggleIcon: Icons.bookmark_rounded,
          isToggled: this.likeBookmark[1], onPressed: () async {
        await widget.likeAndBookmark.updateBookmarked(Session.user);
        if (BottomButtons.update != null) BottomButtons.update(2);
        setState(() {
          this.likeBookmark[1] = !this.likeBookmark[1];
        });
      }, initEveryTime: true)
    ];
  }
}
