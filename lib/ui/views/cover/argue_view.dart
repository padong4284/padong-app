import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ArgueFocus {
  static String replyId;

  static void initialize() {
    replyId = null;
  }
}

class ArgueView extends StatefulWidget {
  final String wikiId;
  final Map<String, List<String>> argues;

  ArgueView(wikiId)
      : this.wikiId = wikiId,
        this.argues = getArgueIdsAPI(wikiId);

  _ArgueViewState createState() => _ArgueViewState();
}

class _ArgueViewState extends State<ArgueView> {
  Map<String, bool> readyReReply = {};
  Map<String, GlobalKey> argueKeys = {};
  List<String> open;
  List<String> closed;
  final TextEditingController _argueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.open = widget.argues['open'];
    this.closed = widget.argues['closed'];
    for (String argueId in this.open + this.closed) {
      this.readyReReply[argueId] = false;
      this.argueKeys[argueId] = new GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.ARGUE,
            onSubmit: this.sendArgue,
            msgController: this._argueController,
            afterHide: true),
        children: [
          SizedBox(
            height: 20,
          ),
          TitleHeader('Open'),
          ...argueList(this.open),
          SizedBox(
            height: 40,
          ),
          TitleHeader('Closed'),
          ...argueList(this.closed),
          SizedBox(height: 65)
        ]);
  }

  Iterable<Widget> argueList(List<String> ids) {
    return ids.map((argueId) {
      List<String> reReplies = getReReplyIdsAPI(argueId);
      return Column(children: [
        GestureDetector(
            onTap: () {
              bool next = !this.readyReReply[argueId];
              setState(() {
                this.initReplyFocus();
                this.readyReReply[argueId] = next;
                ArgueFocus.replyId = next ? argueId : null;
              });
              this.scrollToReply(argueId);
            },
            child: Container(
                key: this.argueKeys[argueId],
                color: this.readyReReply[argueId]
                    ? AppTheme.colors.semiPrimary
                    : null,
                child: ReplyTile(argueId))),
        ...(this.readyReReply[argueId]
            ? reReplies.map((reReplyId) => ReReplyTile(reReplyId))
            : [])
      ]);
    });
  }

  void scrollToReply(String argueId) async {
    await Future.delayed(Duration(milliseconds: 200));
    Scrollable.ensureVisible(this.argueKeys[argueId].currentContext);
  }

  void initReplyFocus() {
    for (String argueId in this.open + this.closed)
      this.readyReReply[argueId] = false;
    ArgueFocus.initialize();
  }

  void sendArgue() {
    if (this._argueController.text.length > 0)
      createReplyAPI({
        'parentId': ArgueFocus.replyId ?? widget.wikiId,
        'description': this._argueController.text,
      });
    this._argueController.text = '';
  }
}
