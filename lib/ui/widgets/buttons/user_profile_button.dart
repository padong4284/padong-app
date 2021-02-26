import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';

class UserProfileButton extends StatelessWidget {
  final String id;
  final Map<String, dynamic> user;
  final UsernamePosition position;
  final double size;

  UserProfileButton(id, {this.position, this.size = 64})
      : this.id = id,
        this.user = getUserAPI(id);

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
        onTap: () {
          // TODO: routing to userprofile page
        },
        child: Container(
            child: Stack(children: [
          Icon(
            Icons.account_circle_rounded,
            size: this.size,
            color: AppTheme.colors.support,
          ),
          CircleAvatar(
            radius: this.size / 2,
            backgroundColor: AppTheme.colors.transparent,
            backgroundImage: this.user['profileImgURL'] != null
                ? NetworkImage(this.user['profileImgURL'])
                : null,
          )
        ])));
  }

  Widget _buildBottomUsername() {
    return Column(
      children: [
        _buildUserIconButton(),
        SizedBox(height: 5),
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
            padding: const EdgeInsets.only(left: 10),
            child: _buildText(AppTheme.fontSizes.regular))
      ],
    );
  }

  Text _buildText(double fontSize) {
    return Text(this.user['username'],
        style: AppTheme.getFont(
          fontSize: fontSize,
          color: position == UsernamePosition.RIGHT_CENTER
              ? AppTheme.colors.semiSupport
              : AppTheme.colors.support,
        ));
  }
}
