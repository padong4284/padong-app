import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';

Map<String, String> getNode(String id) {
  return {'title': 'Title' + id, 'description': "It's sample description"};
}

class PostCard extends StatelessWidget {
  final String _id; // node's _id
  final Map<String, String> node;

  PostCard(id)
      : this.node = getNode(id),
        this._id = id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        // TODO: Routing to Post
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 140, maxHeight: 220),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 3.0,
              margin: const EdgeInsets.all(5),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.colors.lightSupport,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  width: 140,
                  height: 130,
                ),
                Container(
                  alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                                  color: AppTheme.colors.fontPalette[3]))
                        ])),
                BottomButtons(bottoms: [0, null, 0]),
              ]),
            )));
  }
}
