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

class SimpleButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget icon;
  final bool isSuffixICon;
  final ButtonSize buttonSize; //  GIANT, LARGE, REGULAR, SMALL
  final Function() onTap;

  SimpleButton(this.title,
      {this.buttonSize = ButtonSize.REGULAR,
      color,
      this.icon,
      this.isSuffixICon = false,
      this.onTap})
      : this.color = color ?? AppTheme.colors.primary;

  @override
  Widget build(BuildContext context) {
    ButtonProperties buttonProperty =
        simpleButtonSizes[this.buttonSize.toString()];
    var row = [this.icon ?? null, this.buttonText(buttonProperty)]
        .where((element) => element != null)
        .toList();
    if (this.icon != null && this.isSuffixICon) {
      row = List.from(row.reversed);
    }
    return Container(
        height: buttonProperty.height,
        padding: const EdgeInsets.all(0),
        child: FlatButton(
            minWidth: 0,
            color: AppTheme.colors.transparent,
            padding: EdgeInsets.all(0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: row),
            onPressed: () {
              if (this.onTap != null) this.onTap();
            }));
  }

  Text buttonText(buttonProperty) {
    return Text(this.title ?? '',
        textAlign: TextAlign.left,
        style: AppTheme.getFont(
            color: this.color, fontSize: buttonProperty.fontSize));
  }
}
