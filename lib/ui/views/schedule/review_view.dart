import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/views/deck/reply_view.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/cards/lecture_card.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/review_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ReviewView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> lecture;
  final TextEditingController _replyController = TextEditingController();

  ReviewView(String id)
      : this.id = id,
        this.lecture = getLectureAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW,
            onSubmit: this.sendReply,
            msgController: this._replyController,
            afterHide: true),
        appBar: BackAppBar(isClose: true, title: this.lecture['title']),
        children: [
          LectureCard(this.id),
          SizedBox(height: 20),
          TitleHeader('Reviews'),
          ...getReviewIdsAPI(this.id).map((id) => ReviewTile(id)),
          SizedBox(height: 65)
        ]);
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
