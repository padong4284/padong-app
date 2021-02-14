import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/post_card.dart';
import 'package:padong/ui/widgets/horizontal_scroller.dart';

class MainView extends StatefulWidget {
  final bool isPMain;

  MainView({this.isPMain = false});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildTopBar(),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    HorizontalScroller(
                        padding: 3.0,
                        parentLeftPadding: 20.0,
                        parentRightPadding: 20.0,
                        children: Iterable<int>.generate(10)
                            .map((idx) => PostCard(idx.toString()))
                            .toList())
                  ],
                ))));
  }

  AppBar _buildTopBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Visibility(
        child: Container(
          padding: EdgeInsets.only(left: 25.0),
          alignment: Alignment.center,
          child: Text('PADONG',
              style: TextStyle(
                  fontSize: AppTheme.fontSizes.large,
                  color: AppTheme.colors.semiPrimary)),
        ),
        visible: !widget.isPMain,
      ),
      leadingWidth: 110.0,
      actions: [
        SizedBox(
            width: 32.0,
            child: IconButton(
                icon:
                    Icon(Icons.mode_comment, color: AppTheme.colors.support))),
        SizedBox(
            width: 32.0,
            child: IconButton(
                icon: Icon(Icons.account_circle,
                    color: AppTheme.colors.support))),
        SizedBox(width: 25.0)
      ],
    );
  }
}
