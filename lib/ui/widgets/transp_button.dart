import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';
import '../shared/button_properties.dart';

class TranspButton extends StatelessWidget {
  String title;
  Color color;
  IconData icon;
  ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  dynamic callback;

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
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: buttonProperty.height, maxHeight: buttonProperty.height),
      child: FlatButton(
          color: AppTheme.colors.transparent,
          shape: defineShape(),
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                this.icon == null ? null : Icon(this.icon),
                this.title == null
                    ? null
                    : Text(this.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.25,
                            color: this.color,
                            letterSpacing: 0.025,
                            fontSize: buttonProperty.fontSize)),
              ].where((element) => element != null).toList()),
          onPressed: () {
            if (this.callback != null) this.callback();
          }),
    );
  }

  ShapeBorder defineShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), side: BorderSide.none);
  }
}
