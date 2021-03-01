import 'package:flutter/material.dart';
import 'package:padong/core/apis/chat.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/floating_bottom_button.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/chat_room_tile.dart';

class ChatsView extends StatelessWidget {
  final List<String> chatRoomIds;

  ChatsView()
      : this.chatRoomIds = getChatRoomIdsAPI();

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingActionButtonGenerator: (isScrollingDown) => PadongFloatingButton(
          isScrollingDown: isScrollingDown, bottomPadding: 40),
      floatingBottomBarGenerator: (isScrollingDown) => FloatingBottomButton(
          title: 'Chat',
          onTap: () {
            PadongRouter.routeURL('/chat');
          },
          isScrollingDown: isScrollingDown),
      appBar: BackAppBar(title: 'Chats', actions: [
        IconButton(
            icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
            onPressed: () {}) // TODO: more dialog
      ]),
      children: [
        ...this.chatRoomIds.map((chatRoomId) => ChatRoomTile(chatRoomId))
      ],
    );
  }
}
