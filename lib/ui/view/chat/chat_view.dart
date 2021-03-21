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
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/constants.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/button/button.dart';
import 'package:padong/ui/widget/button/switch_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/input.dart';
import 'package:padong/ui/widget/tile/friend_tile.dart';

class ChatView extends StatefulWidget {
  final Node node;

  ChatView(this.node);

  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  int pipIdx = 0;
  List<User> invites = [];
  List<User> friends = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Session.user
        .getFriends()
        .then((_friends) => setState(() => this.friends = _friends));
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(isClose: true, actions: [
          Button('Ok',
              buttonSize: ButtonSize.SMALL,
              borderColor: AppTheme.colors.primary,
              onTap: this.onTabOk,
              shadow: false)
        ]),
        children: [
          this.topArea(),
          Input(
              controller: this._titleController,
              hintText: 'Title of Chat Room',
              type: InputType.UNDERLINE),
          Input(
              controller: this._contentController,
              hintText: CHAT_RULE,
              type: InputType.PLAIN),
          SizedBox(
            height: 40,
          ),
          TitleHeader('Invite Friends'),
          ...this.friends.map((friend) => this.pipIdx != 2
              ? FriendTile(friend,
                  onTapChat: this.inviteFriend,
                  type: FriendTileType.INVITE,
                  invited: this.invites.contains(friend))
              : (this.invites.length == 0 || this.invites.contains(friend)
                  ? FriendTile(friend,
                      onTapChat: this.inviteFriend,
                      type: FriendTileType.INVITE,
                      invited: this.invites.contains(friend))
                  : SizedBox.shrink()))
        ]);
  }

  Widget topArea() {
    return Container(
        height: 55,
        alignment: Alignment.centerLeft,
        child: SwitchButton(
            options: PIPs,
            buttonType: SwitchButtonType.SHADOW,
            initIdx: 0,
            onChange: (String selected) {
              setState(() {
                this.pipIdx = PIPs.indexOf(selected);
                if (this.pipIdx == 2) this.invites = [];
              });
            }));
  }

  void inviteFriend(User friend) {
    setState(() {
      if (this.invites.contains(friend))
        this.invites.remove(friend);
      else {
        if (this.pipIdx == 2) this.invites = [];
        this.invites.add(friend);
      }
    });
  }

  void onTabOk() async {
    if (this.invites.isNotEmpty) {
      this.invites.add(Session.user);
      bool isOneToOne = this.invites.length == 2;
      ChatRoom chatRoom = ChatRoom.fromMap('', {
        'pip': PIPs[this.pipIdx],
        'parentId': widget.node != null ? widget.node.id : '',
        'ownerId': Session.user.id, // first creator
        'title': this._titleController.text.length > 0
            ? this._titleController.text
            : this.invites.map((user) => user.userId).join(', '),
        'description': this._contentController.text,
      });
      bool _isInvite = true;
      if (isOneToOne) {
        String _id = ChatRoom.oneToOne(this.invites[0], this.invites[1]);
        _isInvite = (await ChatRoom.getById(_id)) == null;
        await chatRoom.set(_id);
      } else
        await chatRoom.create();
      if (_isInvite)
        for (User user in this.invites) await chatRoom.invite(user);
      PadongRouter.goBack();
      PadongRouter.routeURL('chatroom?id=${chatRoom.id}', chatRoom);
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No Participant')));
  }
}
