import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/cards/photo_card.dart';

class BuildingCard extends PhotoCard {
  BuildingCard(id) : super(id);

  @override
  Widget build(BuildContext context) {
    return this.baseCard(
        width: 255,
        height: 140,
        child: Row(children: [
          this.pictureArea(isRoate: true, height: 140),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 105,
                    height: 90,
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
}
