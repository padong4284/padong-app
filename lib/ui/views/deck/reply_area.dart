import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';

class ReplyArea extends StatefulWidget {
  final String parentId;
  final List<String> replies;

  ReplyArea(parentId)
      : this.parentId = parentId,
        this.replies = getReplyIdsAPI(parentId);

  _ReplyAreaState createState() => _ReplyAreaState();
}

class _ReplyAreaState extends State<ReplyArea> {
  bool isRendered = false;

  @override
  void initState() {
    super.initState();
    this.isRendered = false;
    this.setRendered();
  }

  void setRendered() async {
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {
      this.isRendered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: this.isRendered ? 1 : 0,
        duration: Duration(milliseconds: 400),
        child: Column(
          children: widget.replies.map((rid) {
            List<String> reReplies = getReReplyIdsAPI(rid);
            return Column(children: [
              ReplyTile(rid),
              ...reReplies.map((rrid) => ReReplyTile(rrid))
            ]);
          }).toList(),
        ));
  }
}
