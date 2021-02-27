import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/core/padong_router.dart';

class PadongFloatingButton extends StatelessWidget {
  final Function onPressAdd;
  final bool isScrollingDown;
  final double bottomPadding;

  PadongFloatingButton(
      {this.onPressAdd, this.isScrollingDown = false, this.bottomPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
            padding: EdgeInsets.only(right: 10.0, bottom: 10.0 + bottomPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              this.onPressAdd != null
                  ? AnimatedOpacity(
                      opacity: this.isScrollingDown ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: FloatingActionButton(
                        heroTag: null,
                        child: Icon(Icons.add,
                            color: AppTheme.colors.base, size: 30),
                        backgroundColor: AppTheme.colors.support,
                        onPressed: this.onPressAdd,
                      ))
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                  opacity: this.isScrollingDown ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 600),
                  child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.search,
                          color: AppTheme.colors.base, size: 30),
                      backgroundColor: AppTheme.colors.primary,
                      onPressed: () {
                        PadongRouter.routeURL('/search');
                      }))
            ])));
  }
}
