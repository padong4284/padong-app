import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';

class VerticalTimeline extends StatelessWidget {
  final String date; // TODO: DateTime class
  final List<String> dots;
  final List<List<Widget>> cards;
  final bool hideTopDate;

  VerticalTimeline(
      {@required this.date,
      @required List<String> dots,
      @required List<List<Widget>> cards,
      this.hideTopDate = false})
      : assert(dots.length == cards.length),
        this.dots = dots,
        this.cards = cards;

  @override
  Widget build(BuildContext context) {
    int len = this.dots.length;
    return Stack(children: [
      Positioned.fill(
          top: this.hideTopDate ? 15 : 35,
          left: 4,
          right: MediaQuery.of(context).size.width -
              2 * (AppTheme.horizontalPadding + 4),
          child: SizedBox(
              width: 2, child: Container(color: AppTheme.colors.lightSupport))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            this.hideTopDate ? SizedBox() : this.getTopDate(),
            ...Iterable<int>.generate(len).map((idx) => Column(children: [
                  this.getDotTime(this.dots[idx]),
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(children: this.cards[idx]))
                ]))
          ]))
    ]);
  }

  Widget getTopDate() {
    bool isToday = false; // TODO check this.head is today
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isToday ? 'Today' : this.date,
            style: AppTheme.getFont(
                color: AppTheme.colors.support,
                fontSize: AppTheme.fontSizes.mlarge,
                isBold: true),
          ),
          isToday
              ? Text(this.date,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.semiSupport,
                      fontSize: AppTheme.fontSizes.regular))
              : null
        ].where((elm) => elm != null).toList());
  }

  Widget getDotTime(String dotTime) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  width: 12, height: 12, color: AppTheme.colors.primary),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(dotTime,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.semiSupport,
                      fontSize: AppTheme.fontSizes.regular)),
            )
          ],
        ));
  }
}
