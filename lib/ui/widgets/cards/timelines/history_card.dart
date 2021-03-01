import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/utils/time_manager.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/node_base.dart';

class HistoryCard extends NodeBase {
  final String wikiId;
  final Map<String, dynamic> event;

  HistoryCard(id, this.wikiId)
      : this.event = getItemAPI(id),
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
        '${TimeManager.formatHM(created.hour)}:${TimeManager.formatHM(created.minute)}:${TimeManager.formatHM(created.second)}';
    return Text(time,
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.small));
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
