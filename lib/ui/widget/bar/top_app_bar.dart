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
import 'package:padong/core/node/common/university.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/simple_button.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final bool withClose;

  TopAppBar(this.title, {this.withClose = false})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // when dark mode, using dark
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: this.withClose
                ? Padding(
                    padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
                    child: SimpleButton('',
                        buttonSize: ButtonSize.LARGE,
                        onTap: () => PadongRouter.goBack(),
                        icon: Icon(Icons.close, size: 25)))
                : InkWell(
                    onTap: () async {
                      if (Session.currUniversity.title != 'PADONG')
                        await Session.changeCurrentUniversity(
                          await University.getUniversityByName('PADONG'));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
                      alignment: Alignment.center,
                      child: Text(this.title,
                        style: AppTheme.getFont(
                            fontSize: AppTheme.fontSizes.large,
                            color: AppTheme.colors.semiPrimary)))),
        leadingWidth: this.withClose ? null : 110.0,
        actions: [
          SizedBox(
              width: 32.0,
              child: IconButton(
                  onPressed: () => PadongRouter.routeURL('/chats'),
                  icon: Icon(Icons.mode_comment,
                      color: AppTheme.colors.support))),
          SizedBox(
              width: 32.0,
              child: IconButton(
                  onPressed: () => PadongRouter.routeURL(
                      '/profile?id=${Session.user.id}&type=user', Session.user),
                  icon: Icon(Icons.account_circle,
                      color: AppTheme.colors.support))),
          SizedBox(width: AppTheme.horizontalPadding)
        ]);
  }
}
