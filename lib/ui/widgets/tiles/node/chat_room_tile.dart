import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

List<String> getParticipantAPI(String chatRoomId) {
  return ['jtj0321', 'kdw0402', 'hsb0422', 'khs0502'];
}

String getLastMessageAPI(String chatRoomId) {
  return "It's Last Message of this chat room. If you want to read, click it!";
}

int getUnreadAPI(String chatRoomId) {
  return int.parse(chatRoomId) % 2 > 0 ? 5 : 0;
}

class ChatRoomTile extends NodeBaseTile {
  final String _id;
  final List<String> participants;

  ChatRoomTile(chatRoomId)
      : this._id = chatRoomId,
        this.participants = getParticipantAPI(chatRoomId),
        super(chatRoomId);

  @override
  Widget profile() {
    // TODO: exclude myself
    List<String> others =
        this.participants.where((id) => id != 'jtj0321').toList();
    return Container();
  }

  @override
  Widget topText() {
    return Text(
        // TODO: exclude myself
        this.participants.where((id) => id != 'jtj0321').join(', '),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  @override
  Widget followText() {
    return Text(getLastMessageAPI(this._id),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.support));
  }

  @override
  Widget bottomArea() {
    int unread = getUnreadAPI(this._id);
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
                  )))
          : SizedBox.shrink()
    ]);
  }
}
