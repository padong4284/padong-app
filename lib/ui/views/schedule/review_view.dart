import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/deck/reply_view.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ReviewView extends PostTile {
  final String id;
  final Map<String, dynamic> post;
  final FocusNode focus = FocusNode();
  final TextEditingController _replyController = TextEditingController();

  ReviewView(String id)
      : this.id = id,
        this.post = getLectureAPI(id),
        super(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW,
            onSubmit: this.sendReply,
            msgController: this._replyController,
            focus: this.focus,
            afterHide: true),
        appBar: BackAppBar(isClose: true),
        children: [
          TitleHeader(this.post['title'], link: "/post/id=${this.id}"),
          PadongMarkdown(this.post['description']),
          SizedBox(height: 20),
          Hero(tag: 'node${this.id}bottoms', child: this.bottomArea()),
          this.underLine(),
          ReplyView(this.id, focus: focus)
        ]);
  }

  @override
  Widget commonArea() {
    return Container(
        height: 40,
        padding: EdgeInsets.only(left: 47, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: this.topText()), this.time()],
          )
        ]));
  }

  Widget underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }

  void sendReply() {
    if (this._replyController.text.length > 0)
      createReplyAPI({
        'parentId': ReReplyFocus.replyId ?? this.id,
        'description': this._replyController.text,
        'rate': TipInfo.starRate,
      });
    this._replyController.text = '';
  }
}
