import 'package:flutter/material.dart';
import 'package:padong/ui//utils/shadow_clip_path.dart';
import 'package:padong/ui//utils/tip_clipper.dart';
import 'package:padong/ui//theme/app_theme.dart';

class TipContainer extends StatelessWidget {
  final double width;
  final Widget child;

  TipContainer({this.width=170, this.child});

  @override
  Widget build(BuildContext context) {
    return ShadowClipPath(
      clipper: TipClipper(),
      shadow: Shadow(
          color: Colors.black12,
          blurRadius: 5
      ),
      child: Container(
        color: AppTheme.colors.base,
        width: this.width,
        height: 50,
        child: this.child
      ),
    );
  }
}