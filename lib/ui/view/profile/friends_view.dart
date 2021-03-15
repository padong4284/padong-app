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
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/container/tab_container.dart';
import 'package:padong/ui/widget/tile/friend_tile.dart';

class FriendsView extends StatefulWidget {
  final bool isMine;
  final User user;

  FriendsView(this.user) : this.isMine = Session.user.id == user.id;

  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  Map<String, List<User>> friends;

  @override
  void initState() {
    super.initState();
    this.friends = {'Friends': [], 'Follows': []};
    if (widget.isMine)
      this.friends['Received'] = [];
    this.getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(isClose: true, title: 'Friends'),
        children: [
          SizedBox(height: 10),
          TabContainer(
              tabWidth: 85.0,
              tabs: this.friends.keys.toList(),
              children: this.friends.values
                  .map((_friends) => this.friendList(_friends))
                  .toList())
        ]);
  }

  Widget friendList(List<User> friends) {
    return Column(
        children: friends
            .map((friend) =>
            InkWell(
                onTap: () =>
                    PadongRouter.routeURL(
                        '/profile?id=${friend.id}&type=user', friend),
                child: FriendTile(friend, onTapChat: this.chatWith,
                    onTapMore: () {
                      // TODO: more dialog
                    })))
            .toList());
  }

  void chatWith(User user) {
    // TODO : check chatRoom exists
    // PadongRouter.routeURL('/chatroom?id=${}', chatroom);
  }

  void getFriends() async {
    List<User> _friends = await widget.user.getFriends();
    for (User friend in _friends) {
      if (friend.friendIds.contains(widget.user.id)) this.friends['Friends'].add(friend);
      else this.friends['Follows'].add(friend);
    }
    if (widget.isMine) this.friends['Received'] = await Session.user.getMyReceived();
    setState((){});
  }
}
