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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widget/button/star_rate_button.dart';
import 'package:padong/ui/widget/card/base_card.dart';
import 'package:padong/ui/widget/card/event_card.dart';
import 'package:padong/ui/widget/padong_future_builder.dart';

class LectureCard extends EventCard {
  final bool isToReview;

  LectureCard(lecture, {this.isToReview = false, isRouting = false})
      : super(lecture, isLecture: true, isRouting: isRouting);

  @override
  Widget build(BuildContext context) {
    return PadongFutureBuilder(
        future: (this.event as Lecture).evaluation,
        builder: (evaluation) => InkWell(
            onTap: this.isRouting
                ? () => PadongRouter.routeURL(
                    '/lecture?id=${this.event.id}', this.event)
                : null,
            child: BaseCard(
                moreText: this.isToReview ? 'Reviews' : null,
                onTapMore: this.isToReview
                    ? () => PadongRouter.routeURL(
                        '/review?id=${this.event.id}&type=lecture', this.event)
                    : null,
                children: [
                  this.timeRange(),
                  Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 15),
                      child: this.isRouting
                          ? this.title()
                          : StarRateButton(
                              rate: evaluation.rate,
                              disable: true,
                            )),
                  ...this.infoList(['professor', 'room', 'grade', 'exam'] +
                      (this.isToReview ? [] : ['attendance', 'book'])),
                ])));
  }
}
