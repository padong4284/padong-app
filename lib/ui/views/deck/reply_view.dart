import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';

class ReReplyFocus {
  static String replyId;

  static void initialize() {
    replyId = null;
  }
}

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
  Map<String, GlobalKey> replyKeys = {};

  @override
  void initState() {
    super.initState();
    for (String rid in widget.replies) {
      this.readyReReply[rid] = false;
      this.replyKeys[rid] = new GlobalKey();
    }
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
    if (!widget.focus.hasFocus) setState(() => this.initReplyFocus());
    return AnimatedOpacity(
        opacity: this.isRendered ? 1 : 0,
        duration: Duration(milliseconds: 400),
        child: Column(children: [
          ...widget.replies.map((rid) {
            List<String> reReplies = getReReplyIdsAPI(rid);
            return Column(children: [
              GestureDetector(
                  onTap: () {
                    bool next = !this.readyReReply[rid];
                    FocusScope.of(context).unfocus();
                    if (next && widget.focus != null)
                      widget.focus.requestFocus();
                    setState(() {
                      this.initReplyFocus();
                      this.readyReReply[rid] = next;
                      ReReplyFocus.replyId = rid;
                    });
                    this.scrollToReply(rid);
                  },
                  child: Container(
                      key: this.replyKeys[rid],
                      color: this.readyReReply[rid]
                          ? AppTheme.colors.semiPrimary
                          : null,
                      child: ReplyTile(rid))),
              ...reReplies.map((rRid) => ReReplyTile(rRid))
            ]);
          }),
          SizedBox(height: 65)
        ]));
  }

  void scrollToReply(String rid) async {
    await Future.delayed(Duration(milliseconds: 200));
    Scrollable.ensureVisible(this.replyKeys[rid].currentContext);
  }

  void initReplyFocus() {
    for (String rid in widget.replies) this.readyReReply[rid] = false;
    ReReplyFocus.initialize();
  }
}
