import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatelessWidget {
  final color = AppTheme.colors.semiSupport;
  final size = 40.0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
                Icons.home_filled,
                color: this.color,
                size: this.size
            ),
          ),
          BottomNavigationBarItem(
            label: 'Wiki',
            icon: Icon(
                Icons.book,
                color: this.color,
                size: this.size
            ),
          ),
          BottomNavigationBarItem(
            label: 'Deck',
            icon: Icon(
                Icons.wysiwyg,
                color: this.color,
                size: this.size
            ),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Icon(
              Icons.event,
              color: this.color,
              size: this.size,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: Icon(
              Icons.place,
              color: this.color,
              size: this.size,
            ),
          ),
        ]);
  }
}
