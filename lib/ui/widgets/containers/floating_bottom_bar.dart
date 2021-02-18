import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class FloatingBottomBar extends StatelessWidget {
  final Widget child;

  FloatingBottomBar({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFFAFAFA), boxShadow: [
        BoxShadow(
            color: Color(0x0a000000),
            blurRadius: 1,
            offset: Offset(0.0, -1.2))
      ]),
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.horizontalPadding, vertical: 12.5),
      child: this.child,
    );
  }
}
