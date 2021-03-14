import 'package:flutter/cupertino.dart';

///*********************************************************************
///* Copyright (C) 2021-2021 Taejun Jang <padong4284@gmail.com>
///* All Rights Reserved.
///* This file is part of PADONG.
///*
///* PADONG can not be copied and/or distributed without the express
///* permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
///*
///* Github [https://github.com/padong4284]
///*********************************************************************
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
  final bool obsecure;
  final EdgeInsets margin;
  final TextEditingController controller;
  final FocusNode focus;
  final String errorText;
  final String helpText;
  final Color borderColor;

  Input(
      {this.hintText,
      this.icon,
      this.type = InputType.ROUNDED,
      this.onPressIcon,
      this.onChanged,
      this.width,
      this.obsecure = false,
      this.margin,
      this.controller,
      this.focus,
      this.iconTopPosition = 0,
      this.isMultiline = false,
      this.toNext = true,
      this.enabled = true,
      this.errorText,
      this.helpText,
      this.borderColor});

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
              top: (this.errorText ==null ?-6: 12) + this.iconTopPosition,
              child: this.icon == null
                  ? SizedBox.shrink()
                  : IconButton(
                      icon: this.icon,
                      onPressed: () {
                        // callback with release
                        if (this.onPressIcon != null) this.onPressIcon();
                        if (this.toNext) node.nextFocus();
                      })),
          this.type == InputType.UNDERLINE
              ? Container(
                  height: 2,
                  margin: const EdgeInsets.only(top: 50),
                  color: AppTheme.colors.semiSupport)
              : SizedBox.shrink()
        ]));
  }

  Widget _buildRoundedInput(node) {
    double fontSize = this.isMultiline
        ? AppTheme.fontSizes.regular
        : AppTheme.fontSizes.mlarge;
    return Column(children: [
      this.errorText == null
          ? SizedBox.shrink()
          : new Align(
          alignment: Alignment.centerLeft, child: new Text(this.errorText, style: TextStyle(color: AppTheme.colors.pointRed))),
      TextField(
          minLines: 1,
          autocorrect: false,
          maxLines: this.isMultiline ? 5 : 1,
          onChanged: this.onChanged,
          enabled: this.enabled,
          controller: this.controller,
          obscureText: this.obsecure,
          focusNode: this.focus,
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
              border: this.getOutline(
                  color:
                      this.errorText == null ? null : AppTheme.colors.pointRed),
              enabledBorder: this.getOutline(
                  color:
                      this.errorText == null ? null : AppTheme.colors.pointRed),
              focusedBorder: this.getOutline(color: AppTheme.colors.primary),
              errorBorder: this.getOutline(color: AppTheme.colors.pointRed)),
          textInputAction: this.isMultiline ? null : TextInputAction.next,
          onEditingComplete: () => node.nextFocus())
    ]);
  }

  Widget _buildOtherInput({bool plain = false}) {
    return TextField(
      maxLines: plain ? null : 1,
      autocorrect: false,
      onChanged: this.onChanged,
      enabled: this.enabled,
      controller: this.controller,
      focusNode: this.focus,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.hintText,
          hintStyle: AppTheme.getFont(
              color: AppTheme.colors.semiSupport,
              fontSize: plain
                  ? AppTheme.fontSizes.regular
                  : AppTheme.fontSizes.xlarge,
              isBold: !plain)),
      style: AppTheme.getFont(
          fontSize:
              plain ? AppTheme.fontSizes.regular : AppTheme.fontSizes.xlarge,
          isBold: !plain),
    );
  }

  OutlineInputBorder getOutline({Color color}) {
    return OutlineInputBorder(
      borderSide: color != null ? BorderSide(color: color) : BorderSide.none,
      borderRadius: BorderRadius.circular(13.0),
    );
  }
}
