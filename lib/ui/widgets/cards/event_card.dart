import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class EventCard extends StatelessWidget {
  final String _id; // node's _id
  final String timeRange;
  final String date;
  final Map<String, String> infos;

  EventCard(
    id, {
    @required this.timeRange,
    @required this.date,
    this.infos, // event -> {Periodicity:[Annual, Monthly, Weekly, None], Alerts: [XX:XX,...]}
  }) : this._id = id;

  @override
  Widget build(BuildContext context) {
    List<String> dateYear = this.splitDateNYear();
    List<Row> infoList = [];
    this.infos.forEach((k, v) => infoList.add(Row(children: [
          Text(k,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2],
                  fontSize: AppTheme.fontSizes.regular,
                  isBold: true)),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(v,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.regular)))
        ])));

    return BaseCard(children: <Widget>[
      Text(this.timeRange,
          style: AppTheme.getFont(
              color: AppTheme.colors.primary,
              fontSize: AppTheme.fontSizes.regular,
              isBold: true)),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 15),
          child: Row(children: [
            Text(dateYear[0],
                style: AppTheme.getFont(
                    color: AppTheme.colors.fontPalette[1],
                    fontSize: AppTheme.fontSizes.large,
                    isBold: true)),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(dateYear[1],
                    style: AppTheme.getFont(
                        color: AppTheme.colors.fontPalette[3],
                        fontSize: AppTheme.fontSizes.mlarge,
                        isBold: true))),
          ])),
      ...infoList,
    ]);
  }

  List<String> splitDateNYear() {
    List<String> mdy = this.date.split("/");
    return [mdy[0] + '/' + mdy[1], mdy[2]];
  }
}
