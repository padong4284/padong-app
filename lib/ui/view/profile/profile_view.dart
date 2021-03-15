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
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/profile_button.dart';
import 'package:padong/ui/widget/card/photo_card.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/container/horizontal_scroller.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/board_list.dart';

class ProfileView extends StatefulWidget {
  final User user;
  final bool isMine;

  ProfileView(this.user) : this.isMine = Session.user.id == user.id;

  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int relation;

  @override
  void initState() {
    super.initState();
    this.relation = (widget.user.getRelationWith(Session.user)?.index ?? 3);
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(actions: this.topAction()),
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: ProfileButton(widget.user,
                  position: UsernamePosition.BOTTOM, size: 80, isBold: true)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: widget.isMine
                ? SizedBox(height: 36)
                : SizedBox(width: 120, child: this.relationButton()),
          ),
          TitleHeader('Friends',
              onTapMore: () => PadongRouter.routeURL(
                  'friends?id=${widget.user.id}&node=user', widget.user)),
          PadongFutureBuilder(
              future: widget.user.getFriends(),
              builder: (friends) => HorizontalScroller(
                      height: 130,
                      emptyMessage: widget.isMine
                          ? 'Show the friends\nwho have received your request.\n'
                          : "You've got a Chance\nto be the first Friend!\n",
                      children: [
                        ...friends.map((friend) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ProfileButton(friend,
                                  position: UsernamePosition.BOTTOM, size: 50),
                            ))
                      ])),
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text('Written',
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.mlarge,
                      isBold: true))),
          PadongFutureBuilder(
              future: widget.user.getWrittens(),
              builder: (posts) => HorizontalScroller(
                  emptyMessage: 'Write your\nOwn Padong Post',
                  padding: 3.0,
                  children: [...posts.map((post) => PhotoCard(post))])),
          SizedBox(height: 10),
          widget.isMine && false
              // FIXME: not possible with current node system.
              ? PadongFutureBuilder(
                  future: Session.user.getMyBoards(),
                  builder: (boards) => BoardList(boards, icons: [
                        Icons.mode_comment_rounded,
                        Icons.favorite_rounded,
                        Icons.bookmark_rounded
                      ]))
              : SizedBox.shrink()
        ]);
  }

  List<Widget> topAction() {
    return widget.isMine
        ? [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () => PadongRouter.routeURL('/configure'),
                    icon: Icon(Icons.settings_rounded,
                        color: AppTheme.colors.support)))
          ]
        : [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support))),
            SizedBox(
                width: 32,
                child: IconButton(
                    // TODO: check chatRoom is exists
                    onPressed: () => PadongRouter.routeURL(
                        '/chat?id=${widget.user.id}&type=user', widget.user),
                    icon: Icon(Icons.mode_comment_outlined,
                        color: AppTheme.colors.support))),
          ];
  }

  Widget relationButton() {
    String _relation = [
      'Friend',
      'Accept', // I received
      'Cancel', // I send
      'Be Friend'
    ][this.relation];
    return Button(_relation,
        buttonSize: ButtonSize.REGULAR,
        icon: this.relation % 2 == 0
            ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                    [
                      Icons.check_rounded,
                      Icons.close_rounded
                    ][this.relation ~/ 2],
                    color: [
                      AppTheme.colors.base,
                      AppTheme.colors.pointRed
                    ][this.relation ~/ 2],
                    size: 15))
            : null,
        paddingRight: this.relation % 2 == 0 ? 10 : 0,
        color: this.relation == 3 ? AppTheme.colors.pointYellow : null,
        borderColor: [
          null,
          AppTheme.colors.primary,
          AppTheme.colors.pointRed,
          null,
        ][this.relation],
        onTap: this.changeRelation,
        shadow: false);
  }

  void changeRelation() {
    setState(() {
      // 0 -> 1, FRIEND -> RECEIVED
      // 1 -> 0, RECEIVED -> FRIEND
      // 2 -> 3, SEND -> null
      // 3 -> 2, null -> SEND
      this.relation = (5 - this.relation) % 4;
      if (this.relation % 2 == 1)
        Session.user.friendIds.remove(widget.user.id);
      else // I send the be Friend
        Session.user.friendIds.add(widget.user.id);
      Session.user.update();
    });
  }
}
