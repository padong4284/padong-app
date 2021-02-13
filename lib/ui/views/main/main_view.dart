import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import '../bottom_navigation_bar.dart';
import '../../widgets/post_card.dart';
import '../../widgets/switch_button.dart';
import '../../shared/types.dart';

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
        body: Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                this._buildTopBar(),
                PostCard('0321'),
                SwitchButton(options: ['anonym', 'profile'], buttonType: SwitchButtonType.SHADOW)
              ],
            )),
        bottomNavigationBar: PadongBottomNavigationBar());
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
            child: Text('PADONG',
                style: TextStyle(
                    fontSize: AppTheme.fontSizes.large,
                    color: AppTheme.colors.semiPrimary)),
            visible: !widget.isPMain,
        ),
        Row(
          children: [
            SizedBox(
                width: 32.0,
                child: IconButton(
                    icon: Icon(Icons.mode_comment,
                        color: AppTheme.colors.support))),
            SizedBox(
                width: 32.0,
                child: IconButton(
                    icon: Icon(Icons.account_circle,
                        color: AppTheme.colors.support)))
          ],
        )
      ],
    );
  }
}
