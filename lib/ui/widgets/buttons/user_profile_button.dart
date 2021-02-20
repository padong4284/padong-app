import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';

Map<String, dynamic> getUserAPI(String id) {
  return {
    // TODO: connect to API
    'username': 'tae7130',
    'profileImageURL': null,
    'universityName': "Seoul Nat'l",
    'entranceYear': 2017,
    "isVerified": true,
  };
}

class UserProfileButton extends StatelessWidget {
  final String username;
  final String profileImageURL;
  final UsernamePosition position;
  final double size;

  UserProfileButton(
      {this.username, this.profileImageURL, this.position, this.size = 64});

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
            child: CircleAvatar(
          radius: this.size / 2, // size = 2*radius
          // TODO: use fire storage get profile image
          // backgroundImage: NetworkImage(this.profileImageURL)
          backgroundColor: AppTheme.colors.lightSupport,
        )));
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
    return Text(this.username,
        style: AppTheme.getFont(
          fontSize: fontSize,
          color: position == UsernamePosition.RIGHT_CENTER
              ? AppTheme.colors.semiSupport
              : AppTheme.colors.support,
        ));
  }
}
