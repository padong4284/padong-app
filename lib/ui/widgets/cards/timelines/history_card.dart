import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
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
  final String wikiId;
  final Map<String, dynamic> event;

  HistoryCard(id, this.wikiId)
      : this.event = getEvent(id),
        super(id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.routePage,
        child: BaseCard(children: [super.build(context)]));
  }

  @override
  Widget time() {
    DateTime created = this.node['createdAt'];
    String time =
        '${this.numFormatting(created.hour)}:${this.numFormatting(created.minute)}:${this.numFormatting(created.second)}';
    return Text(time,
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
  }

  String numFormatting(int num) {
    String numStr = num.toString();
    if (numStr.length != 2) numStr = '0' + numStr;
    return numStr;
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
                  'e' + this.id, // TODO: history ID
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2],
                      fontSize: AppTheme.fontSizes.small),
                ))
          ],
        ));
  }

  @override
  void routePage() =>
      PadongRouter.routeURL('/compare/id=${this.id}&wikiId=${this.wikiId}');
}
