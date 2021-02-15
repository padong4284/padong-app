import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class BaseTile extends StatelessWidget {
  final List<Widget> children;

  BaseTile({@required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.colors.lightSupport),
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: this.children)));
  }
}
