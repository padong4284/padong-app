import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../shared/types.dart';

class Input extends StatelessWidget {
  final hintText;
  final Icon icon;
  final InputType type;
  final double fontSize;
  final Function onPressIcon;
  final void Function(String str) onChanged;

  Input(
      {this.hintText,
      this.icon,
      this.type = InputType.UNDERLINE,
      double fontSize,
      Function onPressIcon,
      void Function(String str) onChanged})
      : this.fontSize = fontSize ?? AppTheme.fontSizes.regular,
        this.onPressIcon = onPressIcon,
        this.onChanged = onChanged;

  Widget build(BuildContext context) {
    if (this.type == InputType.ROUNDED) {
      return _buildRoundedInput();
    } else if (this.type == InputType.UNDERLINE) {
      return _buildOtherInput();
    } else {
      return _buildOtherInput(plain: true);
    }
  }

  Widget _buildRoundedInput() {
    return TextField(
      onChanged: this.onChanged,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.colors.lightSupport,
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: TextStyle(height: 1.8),
          suffixIcon: this.icon == null
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: this.onPressIcon ?? () {
                    print('input icon');
                  },
                  icon: this.icon,
                ),
          contentPadding:
              const EdgeInsets.only(left: 28.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.primary),
            borderRadius: BorderRadius.circular(14.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.transparent),
            borderRadius: BorderRadius.circular(14.0),
          )),
    );
  }

  Widget _buildOtherInput({bool plain = false}) {
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
