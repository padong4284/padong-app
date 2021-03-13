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
import 'package:flutter/services.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/button/simple_button.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  final String link;
  final Function onTapMore;
  final bool isInputHead;

  // link -> BIG with link
  // onTapMore -> Horizontal more
  // isInputHead -> input head
  // no option -> vertical without more
  TitleHeader(this.title, {link, onTapMore, this.isInputHead = false})
      : assert((link == null) || (onTapMore == null)),
        this.link = link,
        this.onTapMore = onTapMore;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      this.link != null ? SizedBox(height: 12) : SizedBox.shrink(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          this.title,
          style: AppTheme.getFont(
              color: this.link != null
                  ? AppTheme.colors.fontPalette[1]
                  : AppTheme.colors.fontPalette[2],
              fontSize: this.link != null
                  ? AppTheme.fontSizes.xlarge
                  : AppTheme.fontSizes.mlarge,
              isBold: true),
        ),
        this.getRightButton(context)
      ]),
      Container(
          height: 2,
          margin: EdgeInsets.only(
              top: this.link != null ? 8 : 3,
              bottom: this.link != null ? 14 : 3),
          alignment: Alignment.bottomLeft,
          color: this.link != null
              ? AppTheme.colors.support
              : this.isInputHead
                  ? AppTheme.colors.lightSupport
                  : AppTheme.colors.semiSupport)
    ]);
  }

  Widget getRightButton(BuildContext context) {
    return this.onTapMore != null
        ? SimpleButton(
            'More',
            onTap: this.onTapMore,
            buttonSize: ButtonSize.SMALL,
            color: AppTheme.colors.primary,
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: AppTheme.colors.primary, size: 15.0),
            isSuffixICon: true,
          )
        : this.link != null
            ? SimpleButton('', // Link Button
                icon: Icon(Icons.link_rounded, size: 25),
                buttonSize: ButtonSize.LARGE, onTap: () {
                if (this.link.length > 0)
                  Clipboard.setData(new ClipboardData(text: this.link))
                      .then((result) {
                    final snackBar = SnackBar(
                        content: Text('Copy link to Clipboard'),
                        action: SnackBarAction(
                            label: 'Ok',
                            textColor: AppTheme.colors.primary,
                            onPressed: () {}));
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
              })
            : SizedBox.shrink();
  }
}
