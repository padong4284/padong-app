import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../shared/types.dart';
import '../../shared/button_properties.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final Color borderColor;
  final ButtonType type; // ROUNDED, STADIUM, CIRCLE
  final Icon icon;
  final ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  final bool shadow;
  final dynamic callback;

  Button(
      {this.title,
      @required this.buttonSize,
      color,
      this.borderColor,
      type,
      this.icon,
      shadow,
      this.callback})
      : this.color = color ?? AppTheme.colors.primary,
        this.type = type ?? ButtonType.STADIUM,
        this.shadow = shadow ?? true;

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
        height: 36.0, width: 72.0, padding: 12.0, fontSize: 13.0),
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
          maxHeight: buttonProperty.height),
      child: RaisedButton(
          color: this.color,
          elevation: this.shadow ? 3.0 : 0.0,
          shape: defineShape(context),
          padding: EdgeInsets.only(
              left: buttonProperty.padding, right: buttonProperty.padding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                this.icon == null ? null : this.icon,
                this.title == null
                    ? null
                    : Text(this.title,
                        textAlign: TextAlign.center,
                        style: AppTheme.getFont(
                            color: this.borderColor ?? AppTheme.colors.base,
                            fontSize: buttonProperty.fontSize)),
              ].where((element) => element != null).toList()),
          onPressed: () {
            if (this.callback != null) this.callback();
          }),
    );
  }

  ShapeBorder defineShape(BuildContext context) {
    BorderSide borderSide = this.borderColor == null
        ? BorderSide.none
        : BorderSide(color: this.borderColor);
    if (this.type == ButtonType.STADIUM) {
      return StadiumBorder(side: borderSide);
    } else if (this.type == ButtonType.CIRCLE) {
      return CircleBorder(side: borderSide);
    } else {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13), side: borderSide);
    }
  }
}