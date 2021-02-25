import 'package:flutter/material.dart';
import 'package:padong/core/apis/padong_router.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

class TabContainer extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;
  final List<String> moreIds;
  final double tabWidth;

  TabContainer({@required tabs, @required children, tabWidth, moreIds})
      : assert(tabs.length == children.length),
        assert(moreIds == null || (moreIds.length == tabs.length)),
        this.tabs = tabs,
        this.children = children,
        this.moreIds = moreIds,
        this.tabWidth = tabWidth ?? 70.0;

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int curIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Iterable<int>.generate(widget.tabs.length)
                  .toList()
                  .map((idx) => InkWell(
                      onTap: () {
                        setState(() {
                          this.curIdx = idx;
                        });
                      },
                      child: Container(
                          height: 25,
                          width: widget.tabWidth,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            widget.tabs[idx],
                            style: TextStyle(
                              fontWeight: this.curIdx == idx
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: AppTheme.fontSizes.mlarge,
                            ),
                          ))))
                  .toList()),
          Container(
              child: AnimatedPadding(
            padding: EdgeInsets.only(
                top: 2, left: this.curIdx * widget.tabWidth, bottom: 15),
            duration: Duration(milliseconds: 200),
            child: Container(
                width: widget.tabWidth - 5,
                height: 2,
                color: AppTheme.colors.support),
          )),
          widget.children[this.curIdx],
        widget.moreIds != null ? Container(
            height: 40.0,
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 10.0),
            child: TranspButton(
              title: 'More',
              buttonSize: ButtonSize.REGULAR,
              icon: Icon(Icons.arrow_forward_ios,
                  color: AppTheme.colors.primary,
                  size: AppTheme.fontSizes.regular),
              isSuffixICon: true,
              callback: () => PadongRouter.routeURL('/board/id=${widget.moreIds[this.curIdx]}'),
            )): SizedBox.shrink(),
          // Positioned(top: 25, child: widget.children[this.curIdx])
        ]));
  }
}
