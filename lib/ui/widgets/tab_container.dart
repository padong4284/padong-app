import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class TabContainer extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;
  final double tabWidth;

  TabContainer({@required tabs, @required children, tabWidth})
      : assert(tabs.length == children.length),
        this.tabs = tabs,
        this.children = children,
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
            padding: EdgeInsets.only(top: 2, left: this.curIdx * widget.tabWidth, bottom:20),
            duration: Duration(milliseconds: 200),
            child:
                Container(width: widget.tabWidth -5, height: 2, color: AppTheme.colors.support),
          )),
          widget.children[this.curIdx],
          // Positioned(top: 25, child: widget.children[this.curIdx])
        ]));
  }
}
