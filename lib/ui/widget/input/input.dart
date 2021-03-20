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
  final labelText;
  final errorText;
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
  final FocusNode focus;
  final bool isPrivacy;

  Input(
      {this.hintText,
      this.labelText,
      this.errorText,
      this.icon,
      this.type = InputType.ROUNDED,
      this.onPressIcon,
      this.onChanged,
      this.width,
      this.margin,
      this.controller,
      this.focus,
      this.iconTopPosition = 0,
      this.isMultiline = false,
      this.toNext = true,
      this.enabled = true,
      this.isPrivacy = false});

  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);
    Widget input;
    if (this.type == InputType.ROUNDED)
      input = this._buildRoundedInput(node);
    else if (this.type == InputType.UNDERLINE)
      input = this._buildOtherInput();
    else
      input = this._buildOtherInput(plain: true);

    return Container(
        width: this.width,
        margin: this.margin ?? const EdgeInsets.all(0),
        child: Stack(children: [
          this.errorText != null
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: AppTheme.colors.base.withAlpha(50)))
              : SizedBox.shrink(),
          Padding(
              padding: EdgeInsets.only(top: this.labelText != null ? 2 : 0),
              child: input),
          Positioned(
              right: 0,
              top: -6 + this.iconTopPosition,
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

  Widget _buildRoundedInput(FocusScopeNode node) {
    double fontSize = this.isMultiline
        ? AppTheme.fontSizes.regular
        : AppTheme.fontSizes.mlarge;
    return TextField(
        minLines: 1,
        autocorrect: false,
        maxLines: this.isMultiline ? 5 : 1,
        onChanged: this.onChanged,
        enabled: this.enabled,
        obscureText: this.isPrivacy,
        controller: this.controller,
        focusNode: this.focus,
        onSubmitted: (_) => (this.onPressIcon ?? () {})(),
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
            labelText: this.labelText,
            labelStyle: this.enabled
                ? null
                : AppTheme.getFont(
                    color: AppTheme.colors.primary,
                    fontSize: AppTheme.fontSizes.mlarge),
            errorText: this.errorText,
            errorStyle: AppTheme.getFont(
                color: AppTheme.colors.pointRed,
                fontSize: AppTheme.fontSizes.small),
            filled: true,
            fillColor: AppTheme.colors.lightSupport,
            border: this.getOutline(),
            focusedBorder: this.getOutline(color: AppTheme.colors.primary),
            errorBorder: this.getOutline(color: AppTheme.colors.pointRed)),
        textInputAction: this.isMultiline ? null : TextInputAction.next,
        onEditingComplete: () => node.nextFocus());
  }

  Widget _buildOtherInput({bool plain = false}) {
    double fontSize =
        plain ? AppTheme.fontSizes.regular : AppTheme.fontSizes.xlarge;
    return TextField(
      maxLines: plain ? null : 1,
      autocorrect: false,
      onChanged: this.onChanged,
      enabled: this.enabled,
      obscureText: this.isPrivacy,
      controller: this.controller,
      focusNode: this.focus,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: this.hintText,
        hintStyle: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: fontSize,
            isBold: !plain),
        labelText: this.labelText,
        errorText: this.errorText,
        errorStyle: AppTheme.getFont(
            color: AppTheme.colors.pointRed,
            fontSize: AppTheme.fontSizes.small),
      ),
      style: AppTheme.getFont(fontSize: fontSize, isBold: !plain),
    );
  }

  OutlineInputBorder getOutline({Color color}) {
    return OutlineInputBorder(
      borderSide: color != null ? BorderSide(color: color) : BorderSide.none,
      borderRadius: BorderRadius.circular(13.0),
    );
  }
}
