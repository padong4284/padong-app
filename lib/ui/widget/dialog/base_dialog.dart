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

class BaseDialog extends StatelessWidget {
  final Widget topComponent;
  final String topTitle;
  final List<Widget> children;
  final List<Widget> actions;

  BaseDialog({this.topTitle, this.topComponent, this.children, this.actions})
      : assert(topTitle == null || topComponent == null);

  static void show(BuildContext context,
      {String topTitle,
      Widget topComponent,
      List<Widget> children,
      List<Widget> actions}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BaseDialog(
              topTitle: topTitle,
              topComponent: topComponent,
              children: children,
              actions: actions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
      title: Container(
          height: 40,
          padding: const EdgeInsets.only(right: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                padding: const EdgeInsets.only(left: 5),
                icon:
                    Icon(Icons.close, color: AppTheme.colors.support, size: 25),
                onPressed: () => Navigator.pop(context)),
            this.topTitle != null
                ? Text(this.topTitle,
                    style: AppTheme.getFont(
                        fontSize: AppTheme.fontSizes.mlarge, isBold: true))
                : (this.topComponent ?? SizedBox.shrink()),
          ])),
      content: Container(
          height: 300,
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: this.children ?? []))),
            SizedBox(height: 5),
            ...this.actions,
            SizedBox(height: 10),
          ])),
    );
  }
}
