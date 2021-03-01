import 'package:flutter/material.dart';
import 'package:padong/core/apis/chat.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/models/pip.dart';
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
            callback: this.createChatRoom,
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
        SizedBox(height: 40,),
        TitleHeader('Invite Friends'),
        ...getFriendIdsAPI().map((id) => FriendTile(id, type: FriendTileType.INVITE))
      ],
    );
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
              });
            }));
  }

  void createChatRoom(Map data) {
    data['parentId'] = Session.user['id'];
    createBoardAPI(data);
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