import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class FriendTile extends StatelessWidget {
  final String id;
  final Map<String, dynamic> user;
  final FriendTileType type;
  final bool invited;
  final Function(String id) chatCallback;
  final Function moreCallback;

  FriendTile(
    id, {
    this.type = FriendTileType.LIST,
    this.chatCallback,
    this.moreCallback,
    this.invited = false,
  })  : this.id = id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            UserProfileButton(this.user['id'], size: 40),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(this.user['username'] + this.id,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.support,
                      fontSize: AppTheme.fontSizes.mlarge,
                      isBold: true)),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(this.user['universityName'],
                        style: AppTheme.getFont(
                            color: AppTheme.colors.primary,
                            fontSize: AppTheme.fontSizes.regular))),
                Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(this.user['entranceYear'].toString(),
                        style: AppTheme.getFont(
                            color: AppTheme.colors.support,
                            fontSize: AppTheme.fontSizes.regular))),
                this.user['isVerified']
                    ? Icon(Icons.verified,
                        color: AppTheme.colors.semiPrimary, size: 20.0)
                    : SizedBox.shrink()
              ])
            ])
          ]),
          this.rightButtons()
        ]));
  }

  Widget rightButtons() {
    if (this.type == FriendTileType.LIST)
      return Row(children: [
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(Icons.mode_comment_outlined,
                  color: AppTheme.colors.support),
              onPressed: this.chatCallback != null
                  ? () => this.chatCallback(this.id)
                  : null,
            )),
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(Icons.more_horiz, color: AppTheme.colors.support),
              onPressed: this.moreCallback != null ? this.moreCallback : null,
            ))
      ]);
    return SizedBox(
        width: 25,
        height: 25,
        child: IconButton(
          icon: Icon(
              this.invited
                  ? CustomIcons.chat_checked
                  : Icons.mode_comment_outlined,
              color: this.invited
                  ? AppTheme.colors.primary
                  : AppTheme.colors.support,
              size: 25),
          padding: const EdgeInsets.all(0),
          onPressed: () => this.chatCallback(this.id),
        ));
  }
}
