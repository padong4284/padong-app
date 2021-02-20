import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';

Map<String, String> getNode(String id) {
  return {'title': 'Title' + id, 'description': "It's sample description"};
}

class BuildingCard extends StatelessWidget {
  final String _id; // node's _id
  final Map<String, String> node;

  BuildingCard(id)
      : this.node = getNode(id),
        this._id = id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        // TODO: Routing to Post
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 255, maxHeight: 140),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3.0,
                margin: const EdgeInsets.all(5),
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.colors.lightSupport,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    width: 140,
                    height: 140,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 105,
                            height: 90,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(this.node['title'],
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.getFont(
                                          color: AppTheme.colors.fontPalette[2],
                                          isBold: true)),
                                  Text(this.node['description'],
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.getFont(
                                        color: AppTheme.colors.fontPalette[3],
                                      ))
                                ])),
                        Container(
                            width: 100,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: BottomButtons(bottoms: [0, null, 0])),
                      ])
                ]))));
  }
}
