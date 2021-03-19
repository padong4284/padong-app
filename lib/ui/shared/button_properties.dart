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
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';

class ButtonProperties {
  double height;
  double width;
  double padding;
  double fontSize;
  double roundedEdge;

  ButtonProperties({this.height, this.width, this.padding = 0, this.fontSize});
}

final buttonSizes = {
  ButtonSize.GIANT: ButtonProperties(
    height: 52.0,
    width: double.infinity,
    fontSize: 16.0,
  ),
  ButtonSize.LARGE: ButtonProperties(
    height: 44.0,
    width: 77.0,
    padding: 13.0,
    fontSize: 14.0,
  ),
  ButtonSize.REGULAR: ButtonProperties(
      height: 36.0, width: 72.0, padding: 12.0, fontSize: 13.0),
  ButtonSize.SMALL: ButtonProperties(
    height: 32.0,
    width: 67.0,
    padding: 12.0,
    fontSize: 12.0,
  )
};

final simpleButtonSizes = {
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

const List<IconData> UnclickIcons = [
  Icons.favorite_border_rounded,
  Icons.mode_comment_outlined,
  Icons.bookmark_border_rounded
];

const List<IconData> ClickIcons = [
  Icons.favorite_rounded,
  Icons.mode_comment,
  Icons.bookmark_rounded
];

final List<Color> ClickColors = [
  AppTheme.colors.pointRed,
  AppTheme.colors.primary,
  AppTheme.colors.pointYellow
];
