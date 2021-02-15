import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/tiles/node/node_base_tile.dart';

class ReReplyTile extends NodeBaseTile {
  ReReplyTile({@required id}) : super(id: id, leftPadding: 40);

  @override
  Widget bottom() {
    this.info['bottoms'][1] = null;
    this.info['bottoms'][2] = null;
    return super.bottom();
  }

  @override
  void callback() {}
}
