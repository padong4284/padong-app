import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/top_boards.dart';
import 'package:padong/ui/widgets/buttons/padong_floating_button.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/univ_door.dart';
import 'package:padong/core/apis/session.dart' as Session;

class MainView extends StatelessWidget {
  final bool isPMain;
  final Map<String, dynamic> univ;

  MainView({this.isPMain = false}) : this.univ = Session.currentUniv;

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      appBar: this.topBar(),
      floatingActionButtonGenerator: (isScrollingDown) =>
          PadongFloatingButton(isScrollingDown: isScrollingDown),
      children: [
        UnivDoor(),
        SizedBox(height: 35),
        TopBoards(this.univ['deckId']),
      ],
    );
  }

  AppBar topBar() {
    return AppBar(
      brightness: Brightness.light,
      // when dark mode, using dark
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: this.isPMain
          ? null
          : Container(
              padding: EdgeInsets.only(left: AppTheme.horizontalPadding),
              alignment: Alignment.center,
              child: Text('PADONG',
                  style: AppTheme.getFont(
                      fontSize: AppTheme.fontSizes.large,
                      color: AppTheme.colors.semiPrimary))),
      leadingWidth: 110.0,
      actions: [
        SizedBox(
            width: 32.0,
            child: IconButton(
                onPressed: () => PadongRouter.routeURL('/chats'),
                icon:
                    Icon(Icons.mode_comment, color: AppTheme.colors.support))),
        SizedBox(
            width: 32.0,
            child: IconButton(
                onPressed: () =>
                    PadongRouter.routeURL('/profile/id=${Session.user['id']}'),
                icon: Icon(Icons.account_circle,
                    color: AppTheme.colors.support))),
        SizedBox(width: AppTheme.horizontalPadding)
      ],
    );
  }
}
