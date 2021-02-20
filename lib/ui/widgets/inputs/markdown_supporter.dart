import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/containers/horizontal_scroller.dart';
import 'package:padong/ui/widgets/inputs/input.dart';

class MarkdownSupporter extends StatelessWidget {
  MarkdownSupporter();

  @override
  Widget build(BuildContext context) {
    return FloatingBottomBar(
        child: Container(
      height: 38,
      child: Row(children: [
        TranspButton(
            callback: this.addPhoto,
            buttonSize: ButtonSize.GIANT,
            icon: Icon(Icons.photo_camera_rounded,
                size: 30, color: AppTheme.colors.support)),
        Container(width:2, color: AppTheme.colors.semiSupport),
        Expanded(child: ListView(
            scrollDirection: Axis.horizontal,
            children:
        Iterable<int>.generate(10).map((idx)=> Button(title: 'testest', buttonSize: ButtonSize.REGULAR)).toList()
        ))
      ]),
    ));
  }

  void addPhoto() {}
}
