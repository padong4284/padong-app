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
  final Map<String, dynamic> event;

  HistoryCard(id)
      : this.event = getEvent(id), super(id);

  @override
  Widget build(BuildContext context) {
    return BaseCard(children: [ super.build(context) ]);
  }

  @override
  Widget bottomArea() {
    return SizedBox(height: 10);
  }
}
