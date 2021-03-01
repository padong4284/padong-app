import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/core/apis/session.dart' as Session;
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class ProfileView extends StatelessWidget {
  final String id;
  final bool isMine;
  final Map<String, dynamic> user;

  ProfileView(String id)
      : this.id = id,
        this.isMine = Session.user['id'] == id,
        this.user = getUserAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(actions: this.topAction()),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
              child: UserProfileButton(this.id,
                  position: UsernamePosition.BOTTOM, size: 80, isBold: true))
        ]);
  }

  List<Widget> topAction() {
    return this.isMine
        ? [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () => PadongRouter.routeURL('/configure'),
                    icon: Icon(Icons.settings_rounded,
                        color: AppTheme.colors.support)))
          ]
        : [
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () => PadongRouter.routeURL('/chat'),
                    icon: Icon(Icons.mode_comment_outlined,
                        color: AppTheme.colors.support))),
            SizedBox(
                width: 32,
                child: IconButton(
                    onPressed: () {}, // TODO: more dialog
                    icon: Icon(Icons.more_horiz_rounded,
                        color: AppTheme.colors.support)))
          ];
  }
}
