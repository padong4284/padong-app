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
import 'package:padong/ui/widget/button/simple_button.dart';

class BaseCard extends StatelessWidget {
  final double height;
  final double width;
  final String moreText;
  final List<Widget> children;
  final Function() onTapMore;
  final double padding;

  BaseCard(
      {@required this.children,
      this.onTapMore,
      this.height,
      this.width,
      this.moreText,
      this.padding = 17});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1.5,
        child: Container(
            width: this.width,
            height: this.height,
            padding: EdgeInsets.all(this.padding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ...this.children,
              this.onTapMore != null
                  ? Container(
                      alignment: Alignment.bottomRight,
                      child: SimpleButton(
                        this.moreText ?? 'More',
                        onTap: this.onTapMore,
                        buttonSize: ButtonSize.SMALL,
                        color: AppTheme.colors.primary,
                        icon: Icon(Icons.arrow_forward_ios_rounded,
                            color: AppTheme.colors.primary, size: 15.0),
                        isSuffixICon: true,
                      ))
                  : SizedBox.shrink()
            ])));
  }
}
