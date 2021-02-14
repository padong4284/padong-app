import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class EventCard extends StatelessWidget {
  final String _id; // node's _id
  final String timeRange;
  final String date;
  final List<String> alerts;
  final String description;

  EventCard(id,
      {@required this.timeRange,
      @required this.date,
      this.alerts,
      this.description})
      : this._id = id;

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: <Widget>[
      Container(
          child: Text(this.timeRange,
              style: AppTheme.getFont(
                  color: AppTheme.colors.primary,
                  fontSize: AppTheme.fontSizes.regular,
                  isBold: true))),
      Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(this.date,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[1],
                  fontSize: AppTheme.fontSizes.large,
                  isBold: true))),
    ]);
  }
}
