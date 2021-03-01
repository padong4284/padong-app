import 'package:flutter/material.dart';
import 'package:padong/core/apis/chat.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/tiles/chat_balloon.dart';

class ChatRoomView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> chatRoom;
  final TextEditingController _msgController = TextEditingController();

  ChatRoomView(id)
      : this.id = id,
        this.chatRoom = getChatRoomAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar:
          BackAppBar(title: this.chatRoom['title'], isClose: true, actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      floatingBottomBar: BottomSender(BottomSenderType.CHAT,
          onSubmit: () {}, msgController: this._msgController),
      children: [
        ...this.chatRoom['messages'].reversed.map((msg)=> ChatBalloon(msg))
      ],
    );
  }
}
