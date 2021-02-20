import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongFloatingButton extends StatelessWidget {
  final Function onPressAdd;
  final bool isScrollingDown;

  PadongFloatingButton({this.onPressAdd, this.isScrollingDown = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: this.isScrollingDown ? 0.0 : 1.0,
        duration: Duration(milliseconds: 500),
        child: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: Container(
                padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  true || this.onPressAdd != null ? FloatingActionButton(
                    child: Icon(Icons.add,
                        color: AppTheme.colors.base, size: 30),
                    backgroundColor: AppTheme.colors.support,
                    onPressed: this.onPressAdd,
                  ): SizedBox.shrink(),
                  SizedBox(height: 10,),
                  FloatingActionButton(
                    child: Icon(Icons.search,
                        color: AppTheme.colors.base, size: 30),
                    backgroundColor: AppTheme.colors.primary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  )
                ]))));
  }
}
