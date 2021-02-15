import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatelessWidget {
  final color = AppTheme.colors.semiSupport;
  final size = 40.0;
  final int selectedIndex;
  Function setSelectedIndex;

  PadongBottomNavigationBar({this.selectedIndex, this.setSelectedIndex});

  @override
  Widget build(BuildContext context) {
    const iconWidth = 57.0;
    return BottomNavigationBar(
      currentIndex: this.selectedIndex ?? 0,
      selectedItemColor: AppTheme.colors.primary,
        unselectedItemColor: this.color,
        onTap: (index) {
          if (index != selectedIndex) {
            _buildRoutes(index, context);
          }
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
                child: Icon(Icons.book, size: this.size),
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
                  color: this.color,
                  size: this.size,
                )),
          ),
        ]);
  }

  Function _buildRoutes(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/main');
        break;
      case 1:
        Navigator.pushNamed(context, '/cover');
        break;
      case 2:
        Navigator.pushNamed(context, '/deck');
        break;
      case 3:
        Navigator.pushNamed(context, '/schedule');
        break;
      case 4:
        Navigator.pushNamed(context, '/map');
        break;
    }
  }
}
