import 'package:flutter/material.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class EventCard extends StatelessWidget {
  final String id; // node's id
  final Map<String, dynamic> event;

  EventCard(id, {isLecture = false})
      : this.id = id,
        this.event = isLecture ? getLectureAPI(id) : getEventAPI(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: [
      this.getTimeRange(),
      Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 15),
          child: this.dateNYear()),
      ...this.getInfoList(['periodicity', 'alerts']),
    ]);
  }

  Text getTimeRange() {
    return Text(this.event['times'][0].split(' | ')[1],
        style: AppTheme.getFont(color: AppTheme.colors.primary, isBold: true));
  }

  List<Row> getInfoList(List<String> infos) {
    List<Row> infoList = [];
    infos.forEach((info) => infoList.add(Row(children: [
          Text(info[0].toUpperCase() + info.substring(1),
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2], isBold: true)),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(this.event[info].toString(),
                  style:
                      AppTheme.getFont(color: AppTheme.colors.fontPalette[2])))
        ])));
    return infoList;
  }

  Widget dateNYear() {
    List<String> mdy = this.event['times'][0].split(' | ')[0].split("/");
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
