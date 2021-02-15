import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';

class BoardListTile extends StatefulWidget {
  final List<String> boards;
  final List<IconData> icons;
  final bool isAlertTile;

  BoardListTile(
      {@required List<String> boards,
      List<IconData> icons,
      isAlertTile = false})
      : assert(isAlertTile || (boards.length == icons.length)),
        this.boards = boards,
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
    this.notifications = Iterable<int>.generate(widget.boards.length).map((_) {
      return false; // get notification or not from firebase
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(
        children: Iterable<int>.generate(widget.boards.length)
            .map(
              (idx) => InkWell(
                  onTap: () {},
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
                        this.boardText(widget.boards[idx])
                      ]))),
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
