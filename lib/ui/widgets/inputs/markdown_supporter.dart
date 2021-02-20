import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';

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
        Container(width: 2, color: AppTheme.colors.semiSupport),
        Expanded(
            child: ListView(
                scrollDirection: Axis.horizontal, children: this.supporters()))
      ]),
    ));
  }

  void addPhoto() {}

  void applyH(int level) {}

  void emphasis() {}

  void blockQuote() {}

  void codeBlock() {}

  List<Widget> supporters() {
    Map<Function, Widget> buttons = {
      () => this.applyH(1): Text('H1',
          style:
              getTextStyle(fontSize: AppTheme.fontSizes.large, isBold: true)),
      () => this.applyH(2): Text('H2',
          style:
              getTextStyle(fontSize: AppTheme.fontSizes.mlarge, isBold: true)),
      () => this.applyH(3):
          Text('H3', style: getTextStyle(isBold: true, isUnderline: true)),
      this.emphasis: Text(' emphasis ',
          style: getTextStyle(
              color: AppTheme.colors.primary,
              backgroundColor: AppTheme.colors.semiPrimary)),
      this.blockQuote: Row(children: [
        Container(width: 4, height: 20, color: AppTheme.colors.support),
        Container(
            padding: const EdgeInsets.only(left: 10),
            color: AppTheme.colors.lightSupport,
            child: Text('block quote', style: getTextStyle()))
      ]),
      this.codeBlock: Container(
          color: AppTheme.colors.support,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text('code block',
              style: getTextStyle(color: AppTheme.colors.base)))
    };
    return buttons
        .map((func, widget) => MapEntry(
            func,
            InkWell(
                onTap: func,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    height: 22,
                    child: widget))))
        .values
        .toList();
  }
}
