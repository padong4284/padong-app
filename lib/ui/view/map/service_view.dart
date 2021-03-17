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
import 'package:padong/core/node/map/service.dart';
import 'package:padong/core/node/schedule/review.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';
import 'package:padong/ui/widget/button/bottom_buttons.dart';
import 'package:padong/ui/widget/button/simple_button.dart';
import 'package:padong/ui/widget/button/star_rate_button.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/padong_markdown.dart';
import 'package:padong/ui/widget/tile/node/review_tile.dart';

class ServiceView extends StatefulWidget {
  final Service service;
  final TextEditingController _replyController = TextEditingController();

  ServiceView(this.service);

  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW,
            onSubmit: this.sendReply,
            msgController: widget._replyController,
            afterHide: true),
        appBar: BackAppBar(likeAndBookmark: widget.service),
        children: [
          SizedBox(height: 20),
          this.topArea(),
          TitleHeader(widget.service.title,
              link: '/service?id=${widget.service.id}'),
          PadongMarkdown(widget.service.description),
          SizedBox(height: 20),
          ...this.bottomLine(),
          PadongFutureBuilder(
              future: widget.service.getChildren(Review(), upToDate: true),
              builder: (reviews) => Column(children: [
                    ...reviews.reversed.map((review) => ReviewTile(review))
                  ])),
          SizedBox(height: 65)
        ]);
  }

  Widget topArea() {
    // almost same service card
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Icon(serviceToIcon(widget.service.serviceCode),
            color: AppTheme.colors.primary, size: 19),
        SizedBox(width: 5),
        Text(serviceToString(widget.service.serviceCode),
            style: AppTheme.getFont(
                color: AppTheme.colors.primary,
                fontSize: AppTheme.fontSizes.mlarge,
                isBold: true))
      ]),
      StarRateButton(
        rate: widget.service.rate,
        disable: true,
      )
    ]);
  }

  List<Widget> bottomLine() {
    return [
      Stack(children: [
        BottomButtons(widget.service, left: 0),
        Positioned(
          bottom: 5,
          right: 0,
          child: SimpleButton('',
              buttonSize: ButtonSize.SMALL,
              icon: Icon(Icons.more_horiz,
                  color: AppTheme.colors.support, size: 20), onTap: () {
            // TODO: click more
          }),
        )
      ]),
      Container(
          height: 2,
          margin: const EdgeInsets.only(top: 10),
          color: AppTheme.colors.lightSupport),
    ];
  }

  void sendReply() async {
    if (widget._replyController.text.length > 0)
      await widget.service.reviewWithRate(
          Session.user, widget._replyController.text, TipInfo.starRate);
    setState(() {
      widget._replyController.text = '';
    });
  }
}
