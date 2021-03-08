import 'package:flutter/material.dart';
import 'package:padong/ui//utils/shadow_clip_path.dart';
import 'package:padong/ui//utils/tip_clipper.dart';
export 'package:padong/ui//utils/tip_clipper.dart'; // for AnchorAlignment
import 'package:padong/ui//theme/app_theme.dart';

class TipContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double radius;
  final double anchor;
  final AnchorAlignment anchorAlignment;

  TipContainer(
      {this.width = 170,
      this.height = 50,
      this.radius = 20,
      this.anchor = 10,
      this.anchorAlignment = AnchorAlignment.LEFT,
      this.child});

  @override
  Widget build(BuildContext context) {
    return ShadowClipPath(
      clipper: TipClipper(radius: this.radius, anchor: this.anchor,
          anchorAlignment: this.anchorAlignment),
      shadow: Shadow(color: Colors.black12, blurRadius: 5),
      child: Container(
          color: AppTheme.colors.base,
          width: this.width,
          height: this.height,
          child: this.child),
    );
  }
}
