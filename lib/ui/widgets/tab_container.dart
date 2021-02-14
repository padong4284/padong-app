import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class TabContainer extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;

  TabContainer({@required tabs, @required children})
      : assert(tabs.length == children.length),
        this.tabs = tabs,
        this.children = children;

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int curIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
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
                          width: 70,
                          alignment: Alignment.centerLeft,
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
            padding: EdgeInsets.only(top: 2, left: this.curIdx * 70.0),
            duration: Duration(milliseconds: 200),
            child:
                Container(width: 60, height: 2, color: AppTheme.colors.support),
          )),
          // Positioned(top: 25, child: widget.children[this.curIdx])
        ]));
  }
}
