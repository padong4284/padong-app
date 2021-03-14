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
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final List<Widget> actions;
  final SwitchButton switchButton;
  final bool isClose;
  final Widget bottom;
  final Statistics likeAndBookmark;

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // when dark mode, using dark
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: this.switchButton != null
            ? this.switchButton
            : this.title != null
                ? Text(this.title,
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
                    this.isClose ? Icons.close : Icons.arrow_back_ios_rounded,
                    size: 25))),
        leadingWidth: 25 + AppTheme.horizontalPadding,
        actions: [
          ...(this.likeAndBookmark != null
              ? this._likeAndBookmarkActions()
              : []),
          ...(this.actions ?? []).map((button) => Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: button is Button ? 67 : 32,
                child: button,
              ))),
          SizedBox(width: AppTheme.horizontalPadding)
        ],
        bottom: this.bottom != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: this.bottom,
              )
            : null);
  }

  List<Widget> _likeAndBookmarkActions() {
    return [
      ToggleIconButton(Icons.favorite_outline_rounded,
          toggleIcon: Icons.favorite_rounded,
          isToggled: this.likeAndBookmark.isLiked(Session.user),
          onPressed: () => this.likeAndBookmark.updateLiked(Session.user)),
      ToggleIconButton(Icons.bookmark_outline_rounded,
          toggleIcon: Icons.bookmark_rounded,
          isToggled: this.likeAndBookmark.isBookmarked(Session.user),
          onPressed: () => this.likeAndBookmark.updateBookmarked(Session.user))
    ];
  }
}
