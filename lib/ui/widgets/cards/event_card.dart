import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';

class EventCard extends StatelessWidget {
  final String _id; // node's _id
  final String timeRange;
  final String date;
  final double rate;
  final bool isToReview;
  final Map<String, String> infos;

  EventCard(
    id, {
    @required this.timeRange,
    date,
    rate,
    isToReview = false,
    this.infos, // event -> {Periodicity:[Annual, Monthly, Weekly, None], Alerts: [XX:XX,...]}
  })  : assert((date != null) ^ (rate != null)),
        assert(!((date != null) && isToReview)),
        this.date = date,
        this.rate = rate,
        this.isToReview = isToReview,
        this._id = id;

  @override
  Widget build(BuildContext context) {
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

    return BaseCard(
        moreText: this.isToReview ? 'Reviews' : null,
        moreCallback: this.isToReview ? () {} : null, // TODO: route to reviews
        children: <Widget>[
          Text(this.timeRange,
              style: AppTheme.getFont(
                  color: AppTheme.colors.primary,
                  fontSize: AppTheme.fontSizes.regular,
                  isBold: true)),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: this.date != null
                  ? this.dateNYear()
                  : StarRateButton(
                      rate: this.rate,
                      disable: true,
                    )),
          ...infoList,
        ]);
  }

  Widget dateNYear() {
    List<String> mdy = this.date.split("/");
    List<String> dateYear = [mdy[0] + '/' + mdy[1], mdy[2]];
    return Row(children: [
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
    ]);
  }
}
