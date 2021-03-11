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
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

const BOTTOM = 40.0;

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final List<Widget> actions;
  final SwitchButton switchButton;
  final bool isClose;
  final Widget bottom;

  BackAppBar(
      {Key key,
      title,
      switchButton,
      this.actions,
      this.isClose = false,
      bottom})
      : preferredSize =
            Size.fromHeight(kToolbarHeight + (bottom != null ? BOTTOM : 0.0)),
        assert(title == null || switchButton == null),
        this.title = title,
        this.switchButton = switchButton,
        this.bottom = bottom,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      // when dark mode, using dark
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
          child: TranspButton(
              buttonSize: ButtonSize.LARGE,
              callback: () {
                Navigator.pop(context);
              },
              icon: Icon(
                  this.isClose ? Icons.close : Icons.arrow_back_ios_rounded,
                  size: 25))),
      leadingWidth: 25 + AppTheme.horizontalPadding,
      actions: [
        ...(this.actions ?? []).map((button) => Container(
            alignment: Alignment.centerRight,
            child: SizedBox(width: button is Button ? 67 : 32, child: button))),
        SizedBox(width: AppTheme.horizontalPadding)
      ],
      bottom: this.bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(BOTTOM), child: this.bottom)
          : null,
    );
  }
}
