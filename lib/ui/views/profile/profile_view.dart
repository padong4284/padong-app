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
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/profile.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ProfileView extends StatefulWidget {
  final String id;
  final bool isMine;
  final Map<String, dynamic> user;

  ProfileView(String id)
      : this.id = id,
        this.isMine = Session.user['id'] == id,
        this.user = getUserAPI(id);

  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int relation;

  @override
  void initState() {
    super.initState();
    this.relation = Session.user['relationWith'](widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(actions: this.topAction()),
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: UserProfileButton(widget.id,
                  position: UsernamePosition.BOTTOM, size: 80, isBold: true)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: widget.isMine
                ? SizedBox(height: 36)
                : SizedBox(width: 120, child: this.relationButton()),
          ),
          TitleHeader('Friends',
              moreCallback: () =>
                  PadongRouter.routeURL('friends?id=${widget.id}')),
          HorizontalScroller(height: 130, children: [
            ...widget.user['friends'].map((id) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: UserProfileButton(widget.id,
                    position: UsernamePosition.BOTTOM, size: 50)))
          ]),
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text('Written',
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.mlarge,
                      isBold: true))),
          HorizontalScroller(moreId: 'bu00900', padding: 3.0, children: [
            ...widget.user['writtenIds'].map((id) => PhotoCard(widget.id))
          ]),
          SizedBox(height: 10),
          widget.isMine
              ? BoardListTile(
                  boardIds: widget.user['myBoards'].sublist(1),
                  icons: [
                    Icons.mode_comment_rounded,
                    Icons.favorite_rounded,
                    Icons.bookmark_rounded
                  ],
                )
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
                  // TODO: check chatRoom is exists
                    onPressed: () => PadongRouter.routeURL('/chat'),
                    icon: Icon(Icons.mode_comment_outlined,
                        color: AppTheme.colors.support))),
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support)))
          ];
  }

  Widget relationButton() {
    return Button(
        title: [
          'Friend',
          'Accept', // I received
          'Cancel', // I send
          'Be Friend'
        ][this.relation],
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
        callback: this.changeRelation,
        shadow: false);
  }

  void changeRelation() {
    if (this.relation > 0) {
      setState(() {
        // 1 -> 0, 2 -> 3. 3 -> 2
        this.relation = (5 - this.relation) % 4;
        updateRelationAPI(widget.id, this.relation);
      });
    }
  }
}
