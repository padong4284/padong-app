import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/cards/building_card.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        BuildingCard('1234')
      ]
    );
  }
}