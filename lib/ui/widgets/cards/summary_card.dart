import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';

class SummaryCard extends StatelessWidget {
  final String _id; // node's _id
  final String title;
  final String description;

  SummaryCard(id, {@required this.title, this.description}) : this._id = id;

  @override
  Widget build(BuildContext context) {
    return BaseCard(height: 160, moreCallback: () {}, children: <Widget>[
      Container(
          child: Text(this.title,
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[1],
                  fontSize: AppTheme.fontSizes.regular,
                  isBold: true))),
      Container(
          height: 75,
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          child: Text('Summary', // TODO: this.description
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[2],
                  fontSize: AppTheme.fontSizes.regular))),
    ]);
  }
}
