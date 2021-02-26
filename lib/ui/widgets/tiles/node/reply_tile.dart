import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class ReplyTile extends NodeBaseTile {
  ReplyTile(id) : super(id, leftPadding: 8);

  @override
  Widget bottomArea() {
    this.node['bottoms'][2] = null;
    return super.bottomArea();
  }

  @override
  void onTap() {
    // TODO: append ReReply to this Reply
  }
}
