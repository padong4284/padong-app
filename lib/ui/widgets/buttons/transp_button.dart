import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/shared/button_properties.dart';

class TranspButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget icon;
  final bool isSuffixICon;
  final ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  final Function callback;

  TranspButton(
      {this.title, @required this.buttonSize, color, this.icon, this.isSuffixICon=false, this.callback})
      : this.color = color ?? AppTheme.colors.primary;

  final buttonSizes = {
    "ButtonSize.GIANT": ButtonProperties(
      height: 30.0,
      fontSize: 24.0,
    ),
    "ButtonSize.LARGE": ButtonProperties(
      height: 25.0,
      fontSize: 18.0,
    ),
    "ButtonSize.REGULAR": ButtonProperties(height: 20.0, fontSize: 14.0),
    "ButtonSize.SMALL": ButtonProperties(
      height: 15.0,
      fontSize: 12.0,
    )
  };

  @override
  Widget build(BuildContext context) {
    ButtonProperties buttonProperty = buttonSizes[this.buttonSize.toString()];
    var row = [this.icon ?? null, this.buttonText(buttonProperty)]
        .where((element) => element != null)
        .toList();
    if (this.icon != null && this.isSuffixICon) {
      row = List.from(row.reversed);
    }
    return Container(
        height: buttonProperty.height,
        padding: const EdgeInsets.all(0),
        child: FlatButton(
            minWidth: 0,
            color: AppTheme.colors.transparent,
            padding: EdgeInsets.all(0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: row),
            onPressed: () {
              if (this.callback != null) this.callback();
            }));
  }

  Text buttonText(buttonProperty) {
    return Text(this.title ?? '',
        textAlign: TextAlign.left,
        style: AppTheme.getFont(
            color: this.color,
            fontSize: buttonProperty.fontSize));
  }
}
