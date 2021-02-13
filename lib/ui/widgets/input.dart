import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';

class Input extends StatelessWidget {

  final hintText;
  final Icon icon;
  final InputType type;
  final double fontSize;
  final Function onPressIcon;

  Input({ this.hintText, this.icon, this.type = InputType.UNDERLINE, double fontSize, onPressIcon}) :
        this.fontSize = fontSize ?? AppTheme.fontSizes.regular,
        this.onPressIcon = onPressIcon;

  Widget build(BuildContext context) {
    if (type == InputType.ROUNDED) {
      return buildRoundedInput();
    } else if (type == InputType.UNDERLINE) {
      return buildOtherInput();
    } else {
      return buildOtherInput(plain: true);
    }
  }

  Widget buildRoundedInput() {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.colors.lightSupport,
              border: InputBorder.none,
              hintText: this.hintText,
              hintStyle: TextStyle(height: 1.8),
              contentPadding: const EdgeInsets.only(
                  left: 28.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(14.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(14.0),
              )
          ),
        ),
        this.icon == null ? SizedBox.shrink() : Align(
            alignment: Alignment.centerRight,
            child: Container(
                child:
                    IconButton(
                      onPressed: this.onPressIcon ?? () {},
                      icon: this.icon,
                    ),
                    padding: EdgeInsets.only(right: 10.0))
        ),
      ],
    );
  }

  Widget buildOtherInput({ bool plain = false }) {
    return TextField(
      style: TextStyle(
        fontSize: this.fontSize,
      ),
      decoration: InputDecoration(
        border: plain ? InputBorder.none : UnderlineInputBorder(),
        hintText: this.hintText,
      ),
    );
  }
}
