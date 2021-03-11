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
import 'package:padong/core/apis/chat.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/switch_button.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/widgets/tiles/friend_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ChatView extends StatefulWidget {
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  int pipIdx = 0;
  List<String> invites = [];
  List<String> friends = getFriendIdsAPI();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(isClose: true, actions: [
          Button(
              title: 'Ok',
              buttonSize: ButtonSize.SMALL,
              borderColor: AppTheme.colors.primary,
              callback: this.onTabOk,
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
              hintText: CHATRULE,
              type: InputType.PLAIN),
          SizedBox(
            height: 40,
          ),
          TitleHeader('Invite Friends'),
          ...this.friends.map((id) => this.pipIdx != 2
              ? FriendTile(id,
                  chatCallback: this.inviteFriend,
                  type: FriendTileType.INVITE,
                  invited: this.invites.contains(id))
              : (this.invites.length == 0 || this.invites.contains(id)
                  ? FriendTile(id,
                      chatCallback: this.inviteFriend,
                      type: FriendTileType.INVITE,
                      invited: this.invites.contains(id))
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

  void inviteFriend(String userId) {
    setState(() {
      if (this.invites.contains(userId))
        this.invites.remove(userId);
      else {
        if (this.pipIdx == 2) this.invites = [];
        this.invites.add(userId);
      }
    });
  }

  void onTabOk() {
    List<String> participants = this.invites + [Session.user['id']];
    Map<String, dynamic> data = {
      'parentId': Session.user['id'],
      'title': this._titleController.text.length > 0
          ? this._titleController.text
          : participants.map((id) => getUserAPI(id)['username']).join(', '),
      'description': this._contentController.text,
      'participants': participants,
      'pip': [PIP.PUBLIC, PIP.INTERNAL, PIP.PRIVATE][this.pipIdx],
    };
    creatChatRoomAPI(data);
    PadongRouter.goBack();
    // TODO: show dialog or snackBar to alert submit complete
  }
}

const CHATRULE = """PIP Access 

- Public
  Group Chat Room which anyone can search
  and join.

- Internal
  Group Chat Room which only invitees 
  participate

- Private
  1:1 Chat Room.
""";
