import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../shared/types.dart';

class Input extends StatelessWidget {
  final hintText;
  final Icon icon;
  final InputType type;
  final Function onPressIcon;
  final void Function(String str) onChanged;
  final bool isMultiline;

  Input({this.hintText,
    this.icon,
    this.type = InputType.UNDERLINE,
    this.onPressIcon,
    this.onChanged,
    this.isMultiline = false});

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
    return Container(
        height: 36,
        child: TextField(
          minLines: 1,
          maxLines: this.isMultiline ? 5 : 1,
          onChanged: this.onChanged,
          decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.colors.lightSupport,
              border: InputBorder.none,
              hintText: this.hintText,
              hintStyle: AppTheme.getFont(
                  color: AppTheme.colors.semiSupport),
              suffixIcon: this.icon == null
                  ? SizedBox.shrink()
                  : IconButton(
                onPressed: this.onPressIcon, // callback
                icon: this.icon,
              ),
              contentPadding: EdgeInsets.only(
                  left: this.isMultiline ? 20.0 : 28.0),
              focusedBorder: this.getOutline(isFocused: true),
              enabledBorder: this.getOutline()),
        ));
  }

  Widget _buildOtherInput({bool plain = false}) {
    return TextField(
      maxLines: plain ? null : 1,
      style: TextStyle(
        fontSize:
        plain ? AppTheme.fontSizes.regular : AppTheme.fontSizes.xlarge,
        fontWeight: plain ? FontWeight.normal : FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: plain
            ? InputBorder.none
            : UnderlineInputBorder(
            borderSide:
            BorderSide(color: AppTheme.colors.semiSupport, width: 2)),
        hintText: this.hintText,
      ),
    );
  }

  OutlineInputBorder getOutline({bool isFocused = false}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: isFocused ? AppTheme.colors.primary : AppTheme.colors
              .transparent),
      borderRadius: BorderRadius.circular(13.0),
    );
  }
}
