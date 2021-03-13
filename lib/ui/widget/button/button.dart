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
import 'package:padong/ui/shared/button_properties.dart';

class Button extends StatelessWidget {
  final String title;
  final ButtonType type; // ROUNDED, STADIUM, CIRCLE
  final ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  final Widget icon;
  final Color color;
  final Color borderColor;
  final bool shadow;
  final double paddingRight;
  final Function() onTap;

  Button(this.title,
      {this.buttonSize = ButtonSize.REGULAR,
      this.type = ButtonType.STADIUM,
      this.icon,
      color,
      borderColor,
      this.shadow = true,
      this.paddingRight = 0,
      this.onTap})
      : this.color = color ??
            (borderColor != null
                ? AppTheme.colors.base
                : AppTheme.colors.primary),
        this.borderColor = borderColor;

  @override
  Widget build(BuildContext context) {
    ButtonProperties buttonProperty = buttonSizes[this.buttonSize];
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  this.icon ?? SizedBox.shrink(),
                  this.title == null
                      ? SizedBox.shrink()
                      : Text(this.title,
                          textAlign: TextAlign.center,
                          style: AppTheme.getFont(
                              color: this.borderColor ?? AppTheme.colors.base,
                              fontSize: buttonProperty.fontSize)),
                  SizedBox(width: this.paddingRight)
                ]),
            onPressed: () {
              if (this.onTap != null) this.onTap();
            }));
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
