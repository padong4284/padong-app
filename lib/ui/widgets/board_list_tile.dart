import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/transp_button.dart';

class BoardListTile extends StatelessWidget {
  final List<String> boards;
  final List<IconData> icons;
  final bool isAlertTile;

  BoardListTile(
      {@required List<String> boards,
      List<IconData> icons,
      isAlertTile = false})
      : assert(!isAlertTile && (boards.length == icons.length)),
        this.boards = boards,
        this.icons = icons,
        this.isAlertTile = isAlertTile;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.colors.lightSupport),
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0,
        child: Container(
            width: 325,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
                children: Iterable<int>.generate(this.boards.length)
                    .map(
                      (idx) => InkWell(
                          onTap: () {},
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Icon(this.icons[idx],
                                        size: 25,
                                        color: AppTheme.colors.support)),
                                this.boardText(this.boards[idx])
                              ]))),
                    )
                    .toList())));
  }

  Text boardText(text) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            height: 1.25,
            color: AppTheme.colors.support,
            letterSpacing: 0.025,
            fontSize: AppTheme.fontSizes.mlarge));
  }
}
