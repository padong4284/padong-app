import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/base_tile.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class NoticeTile extends StatefulWidget {
  final List<String> notices;
  final String boardId;

  NoticeTile(boardId)
      : this.boardId = boardId,
        this.notices = getNoticeIdsAPI(boardId);

  @override
  _NoticeTileState createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  bool isFolded = true;

  @override
  void initState() {
    super.initState();
    this.isFolded = true;
  }

  @override
  Widget build(BuildContext context) {
    return BaseTile(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.campaign,
                          color: AppTheme.colors.support, size: 25)),
                  Text('Notice',
                      style: AppTheme.getFont(
                          color: AppTheme.colors.support,
                          fontSize: AppTheme.fontSizes.mlarge,
                          isBold: true))
                ],
              ),
              widget.notices.length > 2
                  ? TranspButton(
                      title: 'More',
                      isSuffixICon: true,
                      icon: Icon(
                          this.isFolded ? Icons.expand_more : Icons.expand_less,
                          color: AppTheme.colors.primary,
                          size: 20),
                      buttonSize: ButtonSize.REGULAR,
                      callback: () {
                        setState(() {
                          this.isFolded = !this.isFolded;
                        });
                      })
                  : SizedBox.shrink()
            ],
          )),
      Container(height: 2, color: AppTheme.colors.support),
      ...Iterable<int>.generate(this.isFolded ? 2 : widget.notices.length)
          .map(
            (idx) => _NoticeTile(widget.notices[idx],
                (this.isFolded ? 2 : widget.notices.length) == idx + 1),
          )
          .toList()
    ]);
  }
}

class _NoticeTile extends NodeBaseTile {
  final bool isLast;

  _NoticeTile(id, this.isLast) : super(id, noProfile: true);

  @override
  Widget bottomArea() {
    return SizedBox(height: 5);
  }

  @override
  Widget underLine() {
    return this.isLast
        ? SizedBox.shrink()
        : Container(
            height: 2,
            color: AppTheme.colors.lightSupport,
            margin: const EdgeInsets.only(top: 5));
  }
}
