import 'package:flutter/material.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatelessWidget {
  final color = AppTheme.colors.semiSupport;
  final size = 40.0;
  final int selectedIndex;
  final Function setSelectedIndex;

  PadongBottomNavigationBar({this.selectedIndex, this.setSelectedIndex});

  @override
  Widget build(BuildContext context) {
    const iconWidth = 57.0;
    return BottomNavigationBar(
      currentIndex: this.selectedIndex ?? 0,
      selectedItemColor: AppTheme.colors.primary,
        unselectedItemColor: this.color,
        onTap: (index) {
          this.setSelectedIndex(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: SizedBox(
                width: iconWidth,
                child: Icon(Icons.home_filled,
                     size: this.size)),
          ),
          BottomNavigationBarItem(
              label: 'Cover',
              icon: SizedBox(
                width: iconWidth,
                child: Icon(CustomIcons.wiki, size: this.size),
              )),
          BottomNavigationBarItem(
              label: 'Deck',
              icon: SizedBox(
                width: iconWidth,
                child: Icon(Icons.wysiwyg, size: this.size),
              )),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: SizedBox(
                width: iconWidth,
                child: Icon(
                  Icons.event,
                  size: this.size,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: SizedBox(
                width: iconWidth,
                child: Icon(
                  Icons.place,
                  size: this.size,
                )),
          ),
        ]);
  }
}
