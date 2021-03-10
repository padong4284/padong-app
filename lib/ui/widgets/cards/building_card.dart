import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';

class BuildingCard extends PhotoCard {
  BuildingCard(id) : super(id, isBuilding: true);

  @override
  Widget build(BuildContext context) {
    return this.baseCard(
        width: 255,
        height: 140,
        child: Row(children: [
          this.pictureArea(isRotated: true, height: 140),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 105,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: this.titleArea()),
                Container(
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: BottomButtons(left: 8, bottoms: [0, null, 0])),
              ])
        ]));
  }

  @override
  Widget titleArea() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(this.node['title'],
          overflow: TextOverflow.ellipsis,
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[2], isBold: true)),
      SizedBox(height: 5),
      Container(
          height: 55,
          child: Text(this.node['description'],
              style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3])))
    ]);
  }
}
