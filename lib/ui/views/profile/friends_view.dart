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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/containers/tab_container.dart';
import 'package:padong/ui/widgets/tiles/friend_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

const List<String> TABS = ['Friends', 'Receives', 'Sends'];

class FriendsView extends StatelessWidget {
  final String id;
  final bool isMine;
  final Map<String, dynamic> user;

  FriendsView(String id)
      : this.id = id,
        this.isMine = Session.user['id'] == id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(isClose: true, title: 'Friends'),
        children: [
          SizedBox(height: 10),
          TabContainer(
              tabWidth: 85.0,
              tabs: TABS,
              children: TABS
                  .map((tab) => this.friendList(this.user[tab.toLowerCase()]))
                  .toList())
        ]);
  }

  Widget friendList(List<String> friendIds) {
    return Column(
        children: friendIds
            .map((id) => InkWell(
                onTap: () => PadongRouter.routeURL('/profile?id=$id'),
                child: FriendTile(id, chatCallback: this.chatWith,
                    moreCallback: () {
                  // TODO: more dialog
                })))
            .toList());
  }

  void chatWith(String id) {
    // TODO : check chatRoom exists
    PadongRouter.routeURL('/chat_room?id=$id');
  }
}
