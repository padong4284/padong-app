import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  ServiceCard(this.service);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => PadongRouter.routeURL('service?id=${this.service['id']}'),
        child: BaseCard(children: [
          this.title(),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 15),
              child: StarRateButton(rate: this.service['rate'], disable: true)),
          SizedBox(height: 40, child: Text(this.service['description'])),
        ]));
  }

  Widget title() {
    return Row(children: [
      Icon(serviceToIcon(this.service['serviceCode']),
          color: AppTheme.colors.primary, size: 19),
      SizedBox(width: 5),
      Text(this.service['title'],
          style: AppTheme.getFont(
              fontSize: AppTheme.fontSizes.mlarge,
              color: AppTheme.colors.support,
              isBold: true))
    ]);
  }
}
