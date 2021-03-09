import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/map.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/deck/reply_view.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/star_rate_button.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/tiles/node/review_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class ServiceView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> service;
  final TextEditingController _replyController = TextEditingController();

  ServiceView(String id)
      : this.id = id,
        this.service = getServiceAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW,
            onSubmit: this.sendReply,
            msgController: this._replyController,
            afterHide: true),
        appBar: this.likeAndBookmark(),
        children: [
          SizedBox(height: 20),
          this.topArea(),
          TitleHeader(this.service['title'],
              link: '/service?id=${this.service['id']}'),
          PadongMarkdown(this.service['description']),
          SizedBox(height: 20),
          ...this.bottomLine(),
          ...getReviewIdsAPI(this.id).map((id) => ReviewTile(id)),
          SizedBox(height: 65)
        ]);
  }

  Widget topArea() {
    // almost same service card
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Icon(serviceToIcon(this.service['serviceCode']),
            color: AppTheme.colors.primary, size: 19),
        SizedBox(width: 5),
        Text(serviceToString(this.service['serviceCode']),
            style: AppTheme.getFont(
                color: AppTheme.colors.primary,
                fontSize: AppTheme.fontSizes.mlarge,
                isBold: true))
      ]),
      StarRateButton(
        rate: this.service['rate'],
        disable: true,
      )
    ]);
  }

  Widget likeAndBookmark() {
    // TODO: same code Post refactor
    return BackAppBar(actions: [
      ToggleIconButton(
          defaultIcon: Icons.favorite_outline_rounded,
          toggleIcon: Icons.favorite_rounded,
          isToggled: this.service['isLiked'],
          onPressed: () => updateLikeAPI(this.id)),
      ToggleIconButton(
          defaultIcon: Icons.bookmark_outline_rounded,
          toggleIcon: Icons.bookmark_rounded,
          isToggled: this.service['isBookmarked'],
          onPressed: () => updateBookmarkAPI(this.id))
    ]);
  }

  List<Widget> bottomLine() {
    return [
      Stack(children: [
        BottomButtons(left: 0, bottoms: this.service['bottoms']),
        Positioned(
          bottom: 5,
          right: 0,
          child: TranspButton(
              buttonSize: ButtonSize.SMALL,
              icon: Icon(Icons.more_horiz,
                  color: AppTheme.colors.support, size: 20),
              callback: () {
                // TODO: click more
              }),
        )
      ]),
      Container(
          height: 2,
          margin: const EdgeInsets.only(top: 10),
          color: AppTheme.colors.lightSupport),
    ];
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
