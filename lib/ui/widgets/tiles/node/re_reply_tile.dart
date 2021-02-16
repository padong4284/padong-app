import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class ReReplyTile extends NodeBaseTile {
  ReReplyTile(id) : super(id, leftPadding: 40);

  @override
  Widget bottomArea() {
    this.node['bottoms'][1] = null;
    this.node['bottoms'][2] = null;
    return super.bottomArea();
  }

  @override
  void callback() {}
}
