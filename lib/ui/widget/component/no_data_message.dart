import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class NoDataMessage extends StatelessWidget {
  final String message;
  final Alignment alignment;
  final double height;

  NoDataMessage(this.message,
      {this.alignment = Alignment.center, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        alignment: this.alignment,
        child: Text(this.message,
            textAlign: TextAlign.center,
            style: AppTheme.getFont(
                fontSize: AppTheme.fontSizes.mlarge,
                color: AppTheme.colors.primary,
                isBold: true)));
  }
}
