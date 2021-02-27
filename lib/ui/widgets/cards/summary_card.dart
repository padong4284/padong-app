import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/cards/base_card.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';

class SummaryCard extends StatelessWidget {
  final String id; // node's id
  final Map<String, dynamic>  wiki;

  SummaryCard(id) : this.wiki = getWikiAPI(id), this.id = id;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        width: // for draggable
            MediaQuery.of(context).size.width - AppTheme.horizontalPadding * 2,
        height: 160,
        moreCallback: () {},
        children: <Widget>[
          Text(this.wiki['title'],
              style: AppTheme.getFont(
                  color: AppTheme.colors.fontPalette[1],
                  fontSize: AppTheme.fontSizes.large,
                  isBold: true)),
          Container(
              height: 75,
              margin: const EdgeInsets.only(top: 4, bottom: 9),
              child: Text(this.wiki['description'],
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.getFont(
                      color: AppTheme.colors.fontPalette[2]))),
        ]);
  }
}
