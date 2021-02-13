import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';
import '../shared/button_properties.dart';

class TranspButton extends StatelessWidget {
  final String title;
  final Color color;
  final Icon icon;
  final ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  final dynamic callback;

  TranspButton(
      {this.title, @required this.buttonSize, color, this.icon, this.callback})
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
    return this.icon != null
        ? FlatButton.icon(
        icon: this.icon,
        color: AppTheme.colors.transparent,
        height: buttonProperty.height,
        padding: EdgeInsets.all(0.0),
        label: this.title == null
            ? ''
            : this.buttonText(buttonProperty))
        : FlatButton(
        color: AppTheme.colors.transparent,
        height: buttonProperty.height,
        padding: EdgeInsets.all(0.0),
        child: this.buttonText(buttonProperty),
        onPressed: () {
          if (this.callback != null) this.callback();
        });
  }

  Text buttonText(buttonProperty) {
    return Text(this.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.25,
            color: this.color,
            letterSpacing: 0.025,
            fontSize: buttonProperty.fontSize));
  }
}
