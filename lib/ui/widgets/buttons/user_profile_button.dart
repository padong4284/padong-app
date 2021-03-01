import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';

class UserProfileButton extends StatelessWidget {
  final String id;
  final Map<String, dynamic> user;
  final UsernamePosition position;
  final bool isBold;
  final double size;

  UserProfileButton(id, {this.position, this.size = 64, this.isBold = false})
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
        onTap: this.isBold
            ? null
            : () => PadongRouter.routeURL('profile/id=${this.id}'),
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
        SizedBox(height: isBold ? 10 : 5),
        username(AppTheme.fontSizes.small),
        this.isBold ? this.university() : SizedBox.shrink()
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
          isBold: this.isBold,
          fontSize: this.isBold ? AppTheme.fontSizes.large : fontSize,
          color: position == UsernamePosition.RIGHT_CENTER
              ? AppTheme.colors.semiSupport
              : AppTheme.colors.support,
        ));
  }

  Widget university() {
    return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      fontSize: AppTheme.fontSizes.mlarge))),
          this.user['isVerified']
              ? Icon(Icons.verified,
                  color: AppTheme.colors.semiPrimary, size: 20.0)
              : SizedBox.shrink()
        ]));
  }
}
