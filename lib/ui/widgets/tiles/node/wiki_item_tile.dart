import 'package:flutter/material.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class WikiItemTile extends NodeBaseTile {
  WikiItemTile({@required id}) : super(id: id, noProfile: true);

  @override
  Widget bottom() {
    this.info['bottoms'][1] = null;
    return super.bottom();
  }

  @override
  Widget topText() {
    return Text(this.info['title'],
        style: AppTheme.getFont(
            color: AppTheme.colors.support,
            fontSize: AppTheme.fontSizes.regular,
            isBold: true));
  }

  @override
  Widget followText() {
    return Text(this.info['description'],
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(
            color: AppTheme.colors.semiSupport,
            fontSize: AppTheme.fontSizes.regular));
  }
}
