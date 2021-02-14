import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class PadongBottomNavigationBar extends StatefulWidget {
  final color = AppTheme.colors.semiSupport;
  final size = 40.0;

  PadongBottomNavigationBar();

  @override
  _PadongBottomNavigationBarState createState() => _PadongBottomNavigationBarState();
}

class _PadongBottomNavigationBarState extends State<PadongBottomNavigationBar> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const iconWidth = 57.0;
    return BottomNavigationBar(
      currentIndex: this._selectedIndex ?? 0,
      selectedItemColor: AppTheme.colors.primary,
        unselectedItemColor: widget.color,
        onTap: (index) {
          if (index != _selectedIndex) {
            _buildRoutes(index, context);
          }
          setState(() {
            _selectedIndex = index;
          });
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
                     size: widget.size)),
          ),
          BottomNavigationBarItem(
              label: 'Cover',
              icon: SizedBox(
                width: iconWidth,
                child: Icon(Icons.book, size: widget.size),
              )),
          BottomNavigationBarItem(
              label: 'Deck',
              icon: SizedBox(
                width: iconWidth,
                child: Icon(Icons.wysiwyg, size: widget.size),
              )),
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: SizedBox(
                width: iconWidth,
                child: Icon(
                  Icons.event,
                  size: widget.size,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: SizedBox(
                width: iconWidth,
                child: Icon(
                  Icons.place,
                  color: widget.color,
                  size: widget.size,
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
