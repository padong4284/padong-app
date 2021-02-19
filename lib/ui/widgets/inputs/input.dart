import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/shared/types.dart';

class Input extends StatelessWidget {
  final hintText;
  final Icon icon;
  final InputType type;
  final Function onPressIcon;
  final void Function(String str) onChanged;
  final double width;
  final double iconTopPosition;
  final bool isMultiline;
  final bool toNext;
  final bool enabled;
  final EdgeInsets margin;
  final TextEditingController controller;

  Input(
      {this.hintText,
      this.icon,
      this.type = InputType.ROUNDED,
      this.onPressIcon,
      this.onChanged,
      this.width,
      this.margin,
        this.controller,
      this.iconTopPosition = 0,
      this.isMultiline = false,
      this.toNext = true,
      this.enabled = true});

  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    Widget input;
    if (this.type == InputType.ROUNDED) {
      input = this._buildRoundedInput(node);
    } else if (this.type == InputType.UNDERLINE) {
      input = this._buildOtherInput();
    } else {
      input = this._buildOtherInput(plain: true);
    }
    return Container(
        width: this.width,
        margin: this.margin ?? const EdgeInsets.all(0),
        child: Stack(children: [
          input,
          Positioned(
              right: 0,
              top: -6 + this.iconTopPosition,
              child: this.icon == null
                  ? SizedBox.shrink()
                  : IconButton(
                      // callback with release
                      onPressed: () => [
                            this.onPressIcon(),
                            this.toNext ? node.nextFocus() : null
                          ],
                      icon: this.icon))
        ]));
  }

  Widget _buildRoundedInput(node) {
    double fontSize = this.isMultiline
        ? AppTheme.fontSizes.regular
        : AppTheme.fontSizes.mlarge;
    return TextField(
        minLines: 1,
        maxLines: this.isMultiline ? 5 : 1,
        onChanged: this.onChanged,
        enabled: this.enabled,
        controller: this.controller,
        style: AppTheme.getFont(
            color: AppTheme.colors.support, fontSize: fontSize),
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
                left: this.isMultiline ? 20.0 : 28.0,
                top: 9,
                bottom: 9,
                right: this.icon != null
                    ? 45
                    : this.isMultiline
                        ? 20.0
                        : 28.0),
            hintText: this.hintText,
            hintStyle: AppTheme.getFont(
                color: AppTheme.colors.semiSupport, fontSize: fontSize),
            filled: true,
            fillColor: AppTheme.colors.lightSupport,
            border: this.getOutline(),
            focusedBorder: this.getOutline(isFocused: true)),
        textInputAction: this.isMultiline ? null : TextInputAction.next,
        onEditingComplete: () => node.nextFocus());
  }

  Widget _buildOtherInput({bool plain = false}) {
    return TextField(
      maxLines: plain ? null : 1,
      style: TextStyle(
          fontSize:
              plain ? AppTheme.fontSizes.regular : AppTheme.fontSizes.xlarge,
          fontWeight: plain ? FontWeight.normal : FontWeight.bold),
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
      borderSide: isFocused
          ? BorderSide(color: AppTheme.colors.primary)
          : BorderSide.none,
      borderRadius: BorderRadius.circular(13.0),
    );
  }
}
