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
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/cards/event_card.dart';

class LectureCard extends EventCard {
  final bool isToReview;

  LectureCard(id, {this.isToReview = false}) : super(id, isLecture: true);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        moreText: this.isToReview ? 'Reviews' : null,
        moreCallback: this.isToReview
            ? () => PadongRouter.routeURL('/review?id=${this.id}')
            : null,
        children: [
          this.timeRange(),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: StarRateButton(
                rate: this.event['rate'],
                disable: true,
              )),
          ...this.infoList(['professor', 'room', 'grade', 'exam'] +
              (this.isToReview ? [] : ['attendance', 'book'])),
        ]);
  }
}
