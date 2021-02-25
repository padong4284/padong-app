import 'package:flutter/material.dart';
import 'package:padong/core/apis/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';

import 'package:padong/core/apis/deck.dart';

class BoardListTile extends StatefulWidget {
  final List<String> boardIds;
  final List<IconData> icons;
  final bool isAlertTile;

  BoardListTile(
      {@required List<String> boardIds,
      List<IconData> icons,
      List<Function> callbacks,
      isAlertTile = false})
      : assert(isAlertTile || (boardIds.length == icons.length)),
        this.boardIds = boardIds,
        this.icons = icons,
        this.isAlertTile = isAlertTile;

  @override
  _BoardListTileState createState() => _BoardListTileState();
}

class _BoardListTileState extends State<BoardListTile> {
  List<bool> notifications;

  @override
  void initState() {
    super.initState();
    this.notifications =
        Iterable<int>.generate(widget.boardIds.length).map((_) {
      return false; // get notification or not from firebase
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(
        children: Iterable<int>.generate(widget.boardIds.length).map(
      (idx) {
        final board = getBoardAPI(widget.boardIds[idx]);
        return InkWell(
            onTap: () {
              PadongRouter.routeURL('/board/id=${board['id']}');
            },
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: widget.isAlertTile
                          ? ToggleIconButton(
                              defaultIcon: Icons.notifications,
                              toggleIcon: Icons.notifications_off,
                              isToggled: !board['notification'],
                              defaultColor: AppTheme.colors.pointYellow,
                              toggleColor: AppTheme.colors.support,
                              size: 25,
                              onPressed: () {
                                board['notification'] = !board['notification'];
                                setNotificationBoardAPI(board['id'], board['notification']);
                              })
                          : Icon(widget.icons[idx],
                              size: 25, color: AppTheme.colors.support)),
                  this.boardText(board['title'])
                ])));
      },
    ).toList());
  }

  Text boardText(text) {
    return Text(text,
        textAlign: TextAlign.left,
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.mlarge));
  }
}
