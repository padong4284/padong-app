import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/cards/event_card.dart';

class LectureCard extends EventCard {
  final bool isToReview;

  LectureCard(
    id, {
    this.isToReview = false,
  }) : super(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        moreText: this.isToReview ? 'Reviews' : null,
        moreCallback: this.isToReview ? () {} : null, // TODO: route to reviews
        children: [
          this.getTimeRange(),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: StarRateButton(
                rate: this.event['rate'],
                disable: true,
              )),
          ...this.getInfoList(),
          ...this.getInfoList(),
        ]);
  }
}
