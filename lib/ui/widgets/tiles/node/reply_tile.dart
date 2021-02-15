import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class ReplyTile extends NodeBaseTile {
  ReplyTile({@required id}) : super(id: id, leftPadding: 8);

  @override
  Widget bottom() {
    this.info['bottoms'][2] = null;
    return super.bottom();
  }

  @override
  void callback() {
    // TODO: append ReReply to this Reply
  }
}
