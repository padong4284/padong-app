import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/core/apis/session.dart' as Session;

class ChatBalloon extends StatelessWidget {
  // TODO: img!
  final bool isMine;
  final bool hideTimestamp;
  final bool hideSender;
  final Map<String, dynamic> chatMsg;

  ChatBalloon(Map<String, dynamic> chatMsg,
      {Map<String, dynamic> prev, Map<String, dynamic> next})
      : this.chatMsg = chatMsg,
        this.isMine = Session.user['id'] == chatMsg['ownerId'],
        this.hideTimestamp = checkHideTimestamp(chatMsg, next),
        this.hideSender = checkHideSender(prev, chatMsg);

  @override
  Widget build(BuildContext context) {
    List<Widget> message = [this.messageBox(this.isMine)];
    if (!this.hideTimestamp) message.add(this.timestamp(this.isMine));
    return Container(
        padding: EdgeInsets.only(top: this.hideSender ? 0 : 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                this.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              this.isMine ? SizedBox.shrink() : this.sender(),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                this.isMine || this.hideSender
                    ? SizedBox.shrink()
                    : Text(
                        this.chatMsg['username'],
                        style: AppTheme.getFont(
                            color: AppTheme.colors.fontPalette[1]),
                      ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [...(this.isMine ? message.reversed : message)])
              ])
            ]));
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
    String hNm =
        this.chatMsg['createdAt'].toString().split(' ')[1].substring(0, 5);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(hNm,
            style: AppTheme.getFont(
                color: isMine
                    ? AppTheme.colors.semiPrimary
                    : AppTheme.colors.fontPalette[3],
                fontSize: AppTheme.fontSizes.small)));
  }

  Widget sender() {
    return Padding(
        padding: const EdgeInsets.only(top: 5, right: 10),
        child: this.hideSender
            ? SizedBox(width: 40)
            : UserProfileButton(this.chatMsg['ownerId'], size: 40));
  }

  static bool checkHideTimestamp(Map cur, Map next) {
    return next != null
        ? TimeManager.isSameYMDHM(cur['createdAt'], next['createdAt'])
        : false;
  }

  static bool checkHideSender(Map prev, Map cur) {
    return prev != null ? prev['ownerId'] == cur['ownerId'] : false;
  }
}
