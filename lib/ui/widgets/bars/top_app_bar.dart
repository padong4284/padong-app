import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/core/apis/session.dart' as Session;

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;

  TopAppBar(this.title) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // when dark mode, using dark
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              // TODO: routing to Padong Main and change current univ
            },
            child: Container(
                padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
                alignment: Alignment.center,
                child: Text(this.title,
                    style: AppTheme.getFont(
                        fontSize: AppTheme.fontSizes.large,
                        color: AppTheme.colors.semiPrimary)))),
        leadingWidth: 110.0,
        actions: [
          SizedBox(
              width: 32.0,
              child: IconButton(
                  onPressed: () => PadongRouter.routeURL('/chats'),
                  icon: Icon(Icons.mode_comment,
                      color: AppTheme.colors.support))),
          SizedBox(
              width: 32.0,
              child: IconButton(
                  onPressed: () => PadongRouter.routeURL(
                      '/profile?id=${Session.user['id']}'),
                  icon: Icon(Icons.account_circle,
                      color: AppTheme.colors.support))),
          SizedBox(width: AppTheme.horizontalPadding)
        ]);
  }
}
