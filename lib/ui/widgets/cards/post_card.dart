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
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Text(this.node['title'],
                        style: AppTheme.getFont(
                            color: AppTheme.colors.fontPalette[2],
                            isBold: true))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text('Summary', // TODO: this.description2summary
                        style: AppTheme.getFont(
                            color: AppTheme.colors.fontPalette[3]))),
                BottomButtons(bottoms: [0, null, 0]),
              ]),
            )));
  }
}
