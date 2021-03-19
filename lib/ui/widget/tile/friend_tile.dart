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
import 'package:padong/core/node/common/user.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/button/toggle_icon_button.dart';

class FriendTile extends StatelessWidget {
  final User user;
  final FriendTileType type;
  final bool invited;
  final Function(User user) onTapChat;
  final Function onTapMore;

  FriendTile(
    this.user, {
    this.type = FriendTileType.LIST,
    this.onTapChat, // TODO
    this.onTapMore,
    this.invited = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            ProfileButton(this.user, size: 40),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(this.user.userId,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.support,
                      fontSize: AppTheme.fontSizes.mlarge,
                      isBold: true)),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(this.user.university,
                        style: AppTheme.getFont(
                            color: AppTheme.colors.primary,
                            fontSize: AppTheme.fontSizes.regular))),
                Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(this.user.entranceYear.toString(),
                        style: AppTheme.getFont(
                            color: AppTheme.colors.support,
                            fontSize: AppTheme.fontSizes.regular))),
                this.user.isVerified
                    ? Icon(Icons.verified,
                        color: AppTheme.colors.semiPrimary, size: 20.0)
                    : SizedBox.shrink()
              ])
            ])
          ]),
          this.rightButtons()
        ]));
  }

  Widget rightButtons() {
    if (this.type == FriendTileType.LIST)
      return Row(children: [
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: this.onTapMore != null ? this.onTapMore : null,
            )),
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(Icons.mode_comment_outlined,
                  color: AppTheme.colors.support),
              onPressed: this.onTapChat != null
                  ? () => this.onTapChat(this.user)
                  : null,
            )),
      ]);
    return SizedBox(
        width: 25,
        height: 25,
        child: ToggleIconButton(
          Icons.mode_comment_outlined,
          toggleIcon: CustomIcons.chat_checked,
          toggleColor: AppTheme.colors.primary,
          isToggled: this.invited,
          onPressed: () => this.onTapChat(this.user),
          initEveryTime: true,
        ));
  }
}
