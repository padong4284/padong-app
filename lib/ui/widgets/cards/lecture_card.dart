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
