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
    return Container(
        child: Column(children: [
      this.getTopDate(this.date),
      this.getDot(this.ids[0]),
      Padding(padding: const EdgeInsets.only(left:15),child:TimeCard(this.ids[0]))
    ]));
  }

  Widget getTopDate(String date, {bool isToday = false}) {
    return Padding(padding: const EdgeInsets.only(bottom: 10), child:Row(
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
        ].where((elm) => elm != null).toList()));
  }

  Widget getDot(String id) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.5),
          child:
              Container(width: 11, height: 11, color: AppTheme.colors.primary),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('12:0' + id, // TODO: get time by id
              style: AppTheme.getFont(
                  color: AppTheme.colors.semiSupport,
                  fontSize: AppTheme.fontSizes.regular)),
        )
      ],
    );
  }
}
