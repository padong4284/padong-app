import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/node_base.dart';

Map<String, dynamic> getEvent(String id) {
  return {
    'title': 'Birthday',
    'timeRange': '00:00 ~ 24:00',
    'date': '03/21/2021',
    'rate': 4.5,
    'infos': {
      'Periodicity': 'Annual',
      'Alerts': '00:00',
    }
  };
}

class HistoryCard extends NodeBase {
  final String historyId;
  final Map<String, dynamic> event;

  HistoryCard(id)
      : this.event = getEvent(id),
        historyId = id,
        // TODO: get history id by id
        super(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: [super.build(context)]);
  }

  @override
  Widget commonArea() {
    this.node['time'] = '13:27:04'; // TODO:  HH:MM:SS timestamp
    return super.commonArea();
  }

  @override
  Widget bottomArea() {
    return Container(
        padding: const EdgeInsets.only(top: 2),
        transform: Matrix4.translationValues(0.0, 5.0, 0.0),
        child: Stack(
          children: [
            Row(
              children: [
                Icon(Icons.add_rounded,
                    size: 15, color: AppTheme.colors.primary),
                Container(
                    width: 30,
                    child: Text('15', // TODO: get difference ADDED
                        style: AppTheme.getFont(
                            color: AppTheme.colors.primary,
                            fontSize: AppTheme.fontSizes.small))),
                Icon(Icons.remove_rounded,
                    size: 15, color: AppTheme.colors.pointRed),
                SizedBox(
                    width: 30,
                    child: Text('15', // TODO: get difference REMOVED
                        style: AppTheme.getFont(
                            color: AppTheme.colors.pointRed,
                            fontSize: AppTheme.fontSizes.small)))
              ],
            ),
            Positioned(
                bottom: 2,
                right: 0,
                child: Text(
                  'e0434' + this.historyId, // TODO: history ID
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.small),
                ))
          ],
        ));
  }
}
