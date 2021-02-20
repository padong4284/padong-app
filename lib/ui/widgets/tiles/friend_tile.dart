import 'package:flutter/material.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class FriendTile extends StatelessWidget {
  final String _id;
  final Map<String, dynamic> user;
  final FriendTileType type;
  final Function chatCallback;
  final Function moreCallback;

  FriendTile(id,{
    this.type = FriendTileType.LIST,
    this.chatCallback,
    this.moreCallback,
  })  : this._id = id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return _buildCommonFriendTile(this.type == FriendTileType.LIST);
  }

  Widget _buildCommonFriendTile(bool isList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          UserProfileButton(username: this.user['username']),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(this.user['username'],
                          style: AppTheme.getFont(
                              color: AppTheme.colors.support,
                              fontSize: AppTheme.fontSizes.large,
                              isBold: true)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Text(this.user['universityName'],
                              style: AppTheme.getFont(
                                  color: AppTheme.colors.primary,
                                  fontSize: AppTheme.fontSizes.mlarge))),
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Text(this.user['entranceYear'].toString(),
                            style: AppTheme.getFont(
                                color: AppTheme.colors.support,
                                fontSize: AppTheme.fontSizes.mlarge)),
                      ),
                      this.user['isVerified']
                          ? Icon(
                              Icons.verified,
                              color: AppTheme.colors.semiPrimary,
                              size: 20.0,
                            )
                          : SizedBox.shrink()
                    ])
                  ]))
        ]),
        Row(children: _buildIcons(isList))
      ],
    );
  }

  List<Widget> _buildIcons(bool isList) {
    if (isList) {
      return [
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(
                Icons.mode_comment_outlined,
                color: AppTheme.colors.support,
              ),
              onPressed: this.chatCallback,
            )),
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: AppTheme.colors.support,
              ),
              onPressed: this.moreCallback,
            ))
      ];
    }
    return [
      ToggleIconButton(
          defaultIcon: Icons.mode_comment_outlined,
          toggleIcon: CustomIcons.chat_checked,
          defaultColor: AppTheme.colors.support,
          toggleColor: AppTheme.colors.primary,
          onPressed: this.chatCallback)
    ];
  }
}
