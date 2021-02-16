import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/time_card.dart';

class VerticalTimeline extends StatelessWidget {
  final String date; // TODO: DateTime class
  final List<String> ids;

  VerticalTimeline({@required this.date, @required this.ids});

  @override
  Widget build(BuildContext context) {
    int len = this.ids.length;
    return Stack(children: [
      Positioned.fill(
          top: 35,
          left: 4,
          right: MediaQuery.of(context).size.width -
              2 * (AppTheme.horizontalPadding + 4),
          child: SizedBox(
              width: 2, child: Container(color: AppTheme.colors.lightSupport))),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            this.getTopDate(this.date),
            ...Iterable<int>.generate(len).map((idx) => Column(children: [
                  this.getDotHead(this.ids[idx]),
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(children: [
                        TimeCard(this.ids[idx]),
                        TimeCard(this.ids[idx])
                      ]))
                ]))
          ]))
    ]);
  }

  Widget getTopDate(String date, {bool isToday = false}) {
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

  Widget getDotHead(String id) {
    return Padding(
        padding: const EdgeInsets.only(top:10, bottom: 3),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  width: 12, height: 12, color: AppTheme.colors.primary),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('12:0' + id, // TODO: get time by id
                  style: AppTheme.getFont(
                      color: AppTheme.colors.semiSupport,
                      fontSize: AppTheme.fontSizes.regular)),
            )
          ],
        ));
  }
}
