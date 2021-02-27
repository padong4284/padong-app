import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/deck/reply_view.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/toggle_icon_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/post_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

class PostView extends PostTile {
  final String id;
  final Map<String, dynamic> post;
  final FocusNode focus = FocusNode();

  PostView(String id)
      : this.id = id,
        this.post = getPostAPI(id),
        super(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        floatingBottomBar: BottomSender(BottomSenderType.REPLY, focus: this.focus),
        appBar: this.likeAndBookmark(),
        children: [
          Stack(children: [
            Hero(tag: 'node${this.id}owner', child: this.profile()),
            Hero(tag: 'node${this.id}common', child: this.commonArea())
          ]),
          TitleHeader(this.post['title'], isInputHead: true, link: "/post"),
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

  Widget likeAndBookmark(){
    return BackAppBar(actions: [
      ToggleIconButton(
          defaultIcon: Icons.favorite_outline_rounded,
          toggleIcon: Icons.favorite_rounded,
          isToggled: this.post['isLiked'],
          onPressed: () => updateLikeAPI(this.id)),
      ToggleIconButton(
          defaultIcon: Icons.bookmark_outline_rounded,
          toggleIcon: Icons.bookmark_rounded,
          isToggled: this.post['isBookmarked'],
          onPressed: () => updateBookmarkAPI(this.id))
    ]);
  }
}
