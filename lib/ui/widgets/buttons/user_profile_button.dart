import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/padong_router.dart';
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
    if (this.position == UsernamePosition.BOTTOM) {
      return _buildBottomUsername();
    } else if (this.position == UsernamePosition.RIGHT_CENTER) {
      return _buildRightUsername();
    }
    return _buildUserIconButton();
  }

  Widget _buildUserIconButton() {
    return InkWell(
        onTap: () => PadongRouter.routeURL('profile/id=${this.id}'),
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
        ]));
  }

  Widget _buildBottomUsername() {
    return Column(
      children: [
        _buildUserIconButton(),
        SizedBox(height: 5),
        username(AppTheme.fontSizes.small)
      ],
    );
  }

  Widget _buildRightUsername() {
    return Row(
      children: [
        _buildUserIconButton(),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10),
            child: username(AppTheme.fontSizes.regular))
      ],
    );
  }

  Text username(double fontSize) {
    return Text(this.user['username'],
        style: AppTheme.getFont(
          fontSize: fontSize,
          color: position == UsernamePosition.RIGHT_CENTER
              ? AppTheme.colors.semiSupport
              : AppTheme.colors.support,
        ));
  }
}
