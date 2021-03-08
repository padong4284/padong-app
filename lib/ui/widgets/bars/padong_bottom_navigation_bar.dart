import 'package:flutter/material.dart';
import 'package:padong/ui/shared/custom_icons.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatelessWidget {
  final size = 40.0;
  final int selectedIdx;
  final Function setSelectedIdx;

  PadongBottomNavigationBar({this.selectedIdx, this.setSelectedIdx});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.horizontalPadding + 5;
    return BottomNavigationBar(
        currentIndex: this.selectedIdx ?? 0,
        selectedItemColor: AppTheme.colors.primary,
        unselectedItemColor: AppTheme.colors.semiSupport,
        onTap: (int idx) {
          this.setSelectedIdx(idx);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Padding(
                padding: const EdgeInsets.only(left: padding),
                child: Icon(CustomIcons.home_filled_rounded, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Cover',
            icon: Padding(
                padding: const EdgeInsets.only(left: padding / 2),
                child: Icon(CustomIcons.wiki, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Deck',
            icon: Icon(Icons.wysiwyg_rounded, size: this.size),
          ),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Padding(
                padding: const EdgeInsets.only(right: padding / 2),
                child: Icon(Icons.event_rounded, size: this.size)),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: Padding(
                padding: const EdgeInsets.only(right: padding),
                child: Icon(Icons.place_rounded, size: this.size)),
          ),
        ]);
  }
}
