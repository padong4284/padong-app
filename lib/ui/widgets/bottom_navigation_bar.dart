import 'package:flutter/material.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatelessWidget {
  final size = 40.0;
  final int selectedIndex;
  final Function setSelectedIndex;

  PadongBottomNavigationBar({this.selectedIndex, this.setSelectedIndex});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.horizontalPadding + 5;
    return BottomNavigationBar(
        currentIndex: this.selectedIndex ?? 0,
        selectedItemColor: AppTheme.colors.primary,
        unselectedItemColor: AppTheme.colors.semiSupport,
        onTap: (index) {
          this.setSelectedIndex(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Padding(
                padding: const EdgeInsets.only(left: padding),
                child: Icon(Icons.home_filled, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Cover',
            icon: Padding(
                padding: const EdgeInsets.only(left: padding / 2),
                child: Icon(CustomIcons.wiki, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Deck',
            icon: Icon(Icons.wysiwyg, size: this.size),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Padding(
                padding: const EdgeInsets.only(right: padding / 2),
                child: Icon(Icons.event, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: Padding(
                padding: const EdgeInsets.only(right: padding),
                child: Icon(
                  Icons.place,
                  size: this.size,
                )),
          ),
        ]);
  }
}
