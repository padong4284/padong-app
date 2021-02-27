import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';

class ReplyView extends StatefulWidget {
  final String parentId;
  final List<String> replies;
  final FocusNode focus;

  ReplyView(parentId, {this.focus})
      : this.parentId = parentId,
        this.replies = getReplyIdsAPI(parentId);

  _ReplyViewState createState() => _ReplyViewState();
}

class _ReplyViewState extends State<ReplyView> {
  bool isRendered = false;
  Map<String, bool> readyReReply = {};

  @override
  void initState() {
    super.initState();
    for (String rid in widget.replies) this.readyReReply[rid] = false;
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
              GestureDetector(
                  onTap: () {
                    bool prev = this.readyReReply[rid];
                    if (!prev && widget.focus != null)
                      widget.focus.requestFocus();
                    // TODO: scroll to focused reply
                    else
                      FocusScope.of(context).unfocus();
                    setState(() {
                      for (String rid in widget.replies)
                        this.readyReReply[rid] = false;
                      this.readyReReply[rid] = !prev;
                    });
                  },
                  child: Container(
                      color: this.readyReReply[rid]
                          ? AppTheme.colors.semiPrimary
                          : null,
                      child: ReplyTile(rid))),
              ...reReplies.map((rRid) => ReReplyTile(rRid))
            ]);
          }).toList(),
        ));
  }
}
