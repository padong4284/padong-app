import 'package:flutter/material.dart';
import 'package:padong/ui/shared/push_callbacks.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';

Map<String, String> getNode(String id) {
  return {'title': 'Title' + id, 'description': "It's sample description"};
}

class PostCard extends StatelessWidget {
  final String _id; // node's _id
  final Map<String, String> node;
  final Function pushNamedCallback;

  PostCard(id, {this.pushNamedCallback})
      : this.node = getNode(id),
        this._id = id;

  @override
  Widget build(BuildContext context) {
    return this.baseCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        this.pictureArea(),
        Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: this.titleArea()),
        BottomButtons(bottoms: [0, null, 0]),
      ]),
    );
  }

  Widget baseCard(
      {@required Widget child, double width = 140, double height = 220}) {
    return InkWell(
        onTap: () {
          pushNamedCallback('/post', { "id": _id });
        },
        // TODO: Routing to Post
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width, maxHeight: height),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3.0,
                margin: const EdgeInsets.all(5),
                child: child)));
  }

  Widget titleArea() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(this.node['title'],
          overflow: TextOverflow.ellipsis,
          style: AppTheme.getFont(
              color: AppTheme.colors.fontPalette[2], isBold: true)),
      Text(this.node['description'],
          overflow: TextOverflow.ellipsis,
          style: AppTheme.getFont(color: AppTheme.colors.fontPalette[3]))
    ]);
  }

  Widget pictureArea({bool isRoate = false, double height = 130}) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.colors.lightSupport,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(isRoate ? 0 : 5),
              bottomLeft: Radius.circular(isRoate ? 5 : 0))),
      width: 140,
      height: height,
    );
  }
}
