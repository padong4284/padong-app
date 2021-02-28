import 'package:flutter/material.dart';
import 'package:padong/core/padong_router.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class WikiItemTile extends NodeBaseTile {
  WikiItemTile(id) : super(id, noProfile: true);

  @override
  Widget bottomArea() {
    this.node['bottoms'][1] = null;
    return super.bottomArea();
  }

  @override
  Widget topText() {
    return Text(this.node['title'],
        style: AppTheme.getFont(color: AppTheme.colors.support, isBold: true));
  }

  @override
  Widget followText() {
    return Text(this.node['description'],
        overflow: TextOverflow.ellipsis,
        style: AppTheme.getFont(color: AppTheme.colors.semiSupport));
  }

  @override
  void routePage() => PadongRouter.routeURL('/wiki/id=${this.id}');
}
