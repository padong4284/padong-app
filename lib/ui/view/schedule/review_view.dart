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
import 'package:padong/core/node/schedule/lecture.dart';
import 'package:padong/core/service/session.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/template/safe_padding_template.dart';
import 'package:padong/ui/widget/bar/back_app_bar.dart';
import 'package:padong/ui/widget/bar/padong_bottom_bar.dart';
import 'package:padong/ui/widget/card/lecture_card.dart';
import 'package:padong/ui/widget/component/title_header.dart';
import 'package:padong/ui/widget/input/bottom_sender.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';
import 'package:padong/ui/widget/tile/node/review_tile.dart';

class ReviewView extends StatefulWidget {
  final Lecture lecture;
  final TextEditingController _replyController = TextEditingController();

  ReviewView(this.lecture);

  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW,
            onSubmit: this.sendReply,
            msgController: widget._replyController,
            afterHide: true),
        appBar: BackAppBar(isClose: true, title: widget.lecture.title),
        children: [
          LectureCard(widget.lecture),
          SizedBox(height: 20),
          TitleHeader('Reviews'),
          PadongFutureBuilder(
              future: widget.lecture.getReviews(),
              builder: (reviews) => Column(
                    children: [...reviews.reversed.map((review) => ReviewTile(review))],
                  )),
          SizedBox(height: 65)
        ]);
  }

  void sendReply() async {
    if (widget._replyController.text.length > 0)
      await (await widget.lecture.evaluation).reviewWithRate(
          Session.user, widget._replyController.text, TipInfo.starRate);
    setState(() {
      widget._replyController.text = '';
    });
  }
}
