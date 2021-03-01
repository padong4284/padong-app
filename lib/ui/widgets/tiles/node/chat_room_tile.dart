import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';
import 'package:padong/core/apis/session.dart' as Session;

Random rand = Random();

List<String> getParticipantAPI(String chatRoomId) {
  return ['jtj0321', 'kdw0402', 'hsb0422', 'khs0502'].sublist(rand.nextInt(4));
}

String getLastMessageAPI(String chatRoomId) {
  return "It's Last Message of this chat room. If you want to read, click it!";
}

int getUnreadAPI(String chatRoomId) {
  return int.parse(chatRoomId.substring(1)) % 2 > 0 ? 5 : 0;
}

class ChatRoomTile extends NodeBaseTile {
  final String id;
  final List<String> participants;

  ChatRoomTile(chatRoomId)
      : this.id = chatRoomId,
        this.participants = getParticipantAPI(chatRoomId),
        super(chatRoomId);

  @override
  void routePage() => PadongRouter.routeURL('chat_room/id=${this.id}');

  @override
  Widget profile() {
    List<String> others =
        this.participants.where((id) => id != Session.user['id']).toList();
    int len = others.length;
    double size = len > 2 ? 20.0 : (55.0 - len * 15);
    others += [null, null, null];
    return Stack(
      children: [
        SizedBox(width: 40, height: 40),
        Positioned(
            top: 0,
            child: this.profileLine([others[0], others[3]], size,
                len > 2 ? MainAxisAlignment.center : MainAxisAlignment.start)),
        Positioned(
            bottom: 0,
            child: this.profileLine(
                [others[1], others[2]], size, MainAxisAlignment.end))
      ],
    );
  }

  Widget profileLine(List<String> users, double size, MainAxisAlignment align) {
    return Container(
        width: 40,
        child: Row(
          mainAxisAlignment: align,
          children: [
            users[0] != null
                ? UserProfileButton(users[0], size: size)
                : SizedBox.shrink(),
            users[1] != null
                ? UserProfileButton(users[1], size: size)
                : SizedBox.shrink(),
          ],
        ));
  }

  @override
  Widget topText() {
    return Text(
        this.participants.where((id) => id != Session.user['id']).join(', '),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  @override
  Widget followText() {
    return Text(getLastMessageAPI(this.id),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea() {
    int unread = getUnreadAPI(this.id);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox.shrink(),
      unread > 0
          ? Container(
              height: 20,
              margin: const EdgeInsets.only(right: 5, top: 2, bottom: 3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppTheme.colors.pointRed,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    unread.toString(),
                    textAlign: TextAlign.center,
                    style: AppTheme.getFont(
                        color: AppTheme.colors.base,
                        fontSize: AppTheme.fontSizes.small),
                  )),
            )
          : SizedBox.shrink()
    ]);
  }
}
