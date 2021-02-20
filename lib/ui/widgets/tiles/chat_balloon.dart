import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

Map<String, dynamic> getMessageAPI(String id) {
  return {
    'ownerId': '0321',
    'owner': getUserAPI('0321'),
    'createdAt': DateTime.now(),
    'message':
        'this is a chat balloon, U can chat with your friends.\nGood luck!'
  };
}

class ChatBalloon extends StatelessWidget {
  final String _id;
  final Map<String, dynamic> chatMsg;

  ChatBalloon(id)
      : this._id = id,
        this.chatMsg = getMessageAPI(id);

  @override
  Widget build(BuildContext context) {
    bool isMine = true;
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [this.messageBox(isMine), this.timestamp(isMine)],
    ));
  }

  Widget messageBox(bool isMine) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 218),
        child: Container(
            decoration: BoxDecoration(
                color: isMine
                    ? AppTheme.colors.primary
                    : AppTheme.colors.lightSupport,
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
            child: Text(
              this.chatMsg['message'],
              style: AppTheme.getFont(
                  color: isMine
                      ? AppTheme.colors.fontPalette[4]
                      : AppTheme.colors.fontPalette[1]),
            )));
  }

  Widget timestamp(bool isMine) {
    String hNm = this.chatMsg['createdAt'].hour.toString() +
        ':' +
        this.chatMsg['createdAt'].minute.toString();
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(hNm,
            style: AppTheme.getFont(
                color: isMine
                    ? AppTheme.colors.semiPrimary
                    : AppTheme.colors.fontPalette[3],
                fontSize: AppTheme.fontSizes.small)));
  }
}
