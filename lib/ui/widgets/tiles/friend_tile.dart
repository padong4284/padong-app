import 'package:flutter/material.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class FriendTile extends StatefulWidget {
  final String username;
  final String universityName;
  final String enteranceYear;
  final bool isVerified;
  final bool isChecked;
  final FriendTileType type;
  final Function chatCallback;
  final Function moreCallback;

  FriendTile(
      {this.username,
      this.universityName,
      this.enteranceYear,
      this.isVerified = false,
      this.type = FriendTileType.LIST,
      this.chatCallback,
      this.moreCallback,
      this.isChecked = false});

  @override
  _FriendTileState createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCommonFriendTile(widget.type == FriendTileType.LIST);
  }

  Widget _buildCommonFriendTile(bool isList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          UserProfileButton(),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(widget.username,
                          style: AppTheme.getFont(
                              color: AppTheme.colors.support,
                              fontSize: AppTheme.fontSizes.large,
                              isBold: true)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Text(widget.universityName,
                              style: AppTheme.getFont(
                                  color: AppTheme.colors.primary,
                                  fontSize: AppTheme.fontSizes.mlarge))),
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Text(widget.enteranceYear,
                            style: AppTheme.getFont(
                                color: AppTheme.colors.support,
                                fontSize: AppTheme.fontSizes.mlarge)),
                      ),
                      widget.isVerified
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
              onPressed: widget.chatCallback,
            )),
        SizedBox(
            width: 32.0,
            child: IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: AppTheme.colors.support,
              ),
              onPressed: widget.moreCallback,
            ))
      ];
    }
    return [
      IconButton(
          icon: widget.isChecked
              ? Icon(
                  CustomIcons.chat_checked,
                  color: AppTheme.colors.primary,
                )
              : Icon(Icons.mode_comment_outlined),
          onPressed: widget.chatCallback)
    ];
  }
}
