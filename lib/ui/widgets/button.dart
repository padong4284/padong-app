import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';
import '../shared/button_properties.dart';

class Button extends StatelessWidget {

  String title;
  Color color;
  Color borderColor;
  ButtonType type; // ROUNDED, STADIUM, CIRCLE
  IconData icon;
  ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  dynamic callback;

  Button({ this.title, @required this.buttonSize, color, this.borderColor, type, this.icon, this.callback }):
    this.color = color ?? AppTheme.colors.primary,
    this.type = type ?? ButtonType.STADIUM;

  final buttonSizes = {
    "ButtonSize.GIANT": ButtonProperties(
      height: 52.0,
      width: double.infinity,
      fontSize: 16.0,
    ),
    "ButtonSize.LARGE": ButtonProperties(
      height: 44.0,
      width: 77.0,
      padding: 13.0,
      fontSize: 14.0,
    ),
    "ButtonSize.REGULAR": ButtonProperties(
      height: 36.0,
      width: 72.0,
      padding: 12.0,
      fontSize: 13.0
    ),
    "ButtonSize.SMALL": ButtonProperties(
      height: 32.0,
      width: 67.0,
      padding: 12.0,
      fontSize: 12.0,
    )
  };

  @override
  Widget build(BuildContext context) {
    ButtonProperties buttonProperty = buttonSizes[this.buttonSize.toString()];
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: buttonProperty.width,
          minHeight: buttonProperty.height,
          maxHeight: buttonProperty.height
        ),
        child: RaisedButton(
            color: this.color,
            shape: defineShape(context),
            padding: EdgeInsets.only(left: buttonProperty.padding, right: buttonProperty.padding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  this.icon == null ? null : Icon(this.icon),
                  this.title == null ? null : Text(this.title, textAlign: TextAlign.center, style: TextStyle(height: 1.25, color: this.borderColor ?? AppTheme.colors.base, letterSpacing: 0.025, fontSize: buttonProperty.fontSize)),
                ].where((element) => element != null).toList()
            ),
            onPressed: () {
              print("clicked");
              if (this.callback != null) this.callback();
            }
        ),
      );
  }

  ShapeBorder defineShape(BuildContext context) {
    BorderSide borderSide = this.borderColor == null ? BorderSide.none : BorderSide(color: this.borderColor);
    if (this.type == ButtonType.STADIUM) {
      return StadiumBorder(side: borderSide);
    } else if (this.type == ButtonType.CIRCLE) {
      return CircleBorder(side: borderSide);
    } else {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(13), side: borderSide);
    }
  }
}