import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';

class UserProfileButton extends StatelessWidget {
  final String username;
  final UsernamePosition position;
  final Color textColor;
  final Function callback;

  UserProfileButton({this.username, this.position, Color color, this.callback})
      : this.textColor = color ?? AppTheme.colors.support;

  @override
  Widget build(BuildContext context) {
    if (position == UsernamePosition.BOTTOM) {
      return _buildBottomUsername();
    } else if (position == UsernamePosition.RIGHT_CENTER) {
      return _buildRightCenterUsername();
    }
    return _buildUserIconButton();
  }

  Widget _buildUserIconButton() {
    return InkWell(
      onTap: this.callback,
      child: CircleAvatar(
        radius: 35,
        // TODO: use fire storage get emblem
        // backgroundImage: NetworkImage(_profileImageURL)
        // https://here4you.tistory.com/235
        backgroundColor: AppTheme.colors.lightSupport,
      )
    );
  }

  Widget _buildBottomUsername() {
    return Column(
        children: [
        _buildUserIconButton(),
          _buildText(AppTheme.fontSizes.small)
    ],
    );
  }

  Widget _buildRightCenterUsername() {
    return Row(
      children: [
        _buildUserIconButton(),
        Container(
            alignment: Alignment.center,
            child: _buildText(AppTheme.fontSizes.regular)
        )
      ],
    );
  }

  Text _buildText(double fontSize) {
    return Text(
        this.username,
        style: TextStyle(
          fontSize: fontSize,
          color: this.textColor,
          height: 0.5,
        ));
  }
}


