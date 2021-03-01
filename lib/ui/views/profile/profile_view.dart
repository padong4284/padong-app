import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/tiles/board_list_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';
import 'package:padong/core/apis/session.dart' as Session;

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
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: UserProfileButton(this.id,
                  position: UsernamePosition.BOTTOM, size: 80, isBold: true)),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: this.isMine
                ? SizedBox(height: 36)
                : SizedBox(
                    width: 120,
                    child: Button(
                        title: 'Friend',
                        buttonSize: ButtonSize.REGULAR,
                        shadow: false)),
          ),
          TitleHeader('Friends',
              moreCallback: () =>
                  PadongRouter.routeURL('friends/id=${this.id}')),
          HorizontalScroller(height: 130, children: [
            ...this.user['friends'].map((id) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: UserProfileButton(this.id,
                    position: UsernamePosition.BOTTOM, size: 50)))
          ]),
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text('Written',
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.mlarge,
                      isBold: true))),
          HorizontalScroller(moreId: 'bu00900', padding: 3.0, children: [
            ...this.user['writtenIds'].map((id) => PhotoCard(this.id))
          ]),
          SizedBox(height: 10),
          this.isMine
              ? BoardListTile(
                  boardIds: this.user['myBoards'].sublist(1),
                  icons: [
                    Icons.mode_comment_rounded,
                    Icons.favorite_rounded,
                    Icons.bookmark_rounded
                  ],
                )
              : SizedBox.shrink()
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
