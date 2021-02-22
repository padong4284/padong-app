import 'package:flutter/material.dart';
import 'package:padong/core/models/deck/board.dart';
import 'package:padong/ui/shared/push_callbacks.dart' as pushNamedCallback;
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';


ModelBoard getBoardAPI(String id) {
  ModelBoard result;
  if (id == '0') {
    result = ModelBoard(id: id, title: 'Global', description: '''
This board is GLOBAL board.
Everyone can read and write in this board.
''');
  } else if (id == '1') {
    result = ModelBoard(id: id, title: 'Public', description: '''
This board is PUBLIC board.
Everyone can read this board.
But, only Georgia Tech students can write.
''');
  } else {
    result = ModelBoard(id: id, title: 'Internal', description: '''
This board is INTERNAL board.
ONLY Georgia Tech students can read and write.
''');
  }
  return result;
}

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
    this.notifications = Iterable<int>.generate(widget.boardIds.length).map((_) {
      return false; // get notification or not from firebase
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(
        children: Iterable<int>.generate(widget.boardIds.length)
            .map(
              (idx) {
                final board = getBoardAPI(widget.boardIds[idx]);
                return InkWell(
                  onTap: () {
                    pushNamedCallback.registeredPushNamed('/board/id=${board.id}');
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    this.notifications[idx] =
                                        widget.isAlertTile &&
                                            !this.notifications[idx];
                                  });
                                },
                                child: Icon(
                                    widget.isAlertTile
                                        ? this.notifications[idx]
                                            ? Icons.notifications
                                            : Icons.notifications_off
                                        : widget.icons[idx],
                                    size: 25,
                                    color: this.notifications[idx]
                                        ? AppTheme.colors.pointYellow
                                        : AppTheme.colors.support))),
                        this.boardText(board.title)
                      ])));},
            )
            .toList());
  }

  Text boardText(text) {
    return Text(text,
        textAlign: TextAlign.left,
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.mlarge));
  }
}
