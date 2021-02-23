import 'package:flutter/material.dart';
import 'package:padong/core/models/deck/post.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

ModelPost getPostAPI(String id) {
  return ModelPost(title: 'Title', description:
'''
This is the content of this post. You can fill it
with the "MarkDown".

If you don't know the "MarkDown", please
visit this link!

`emphasis` is shown as emphasis
**bolder** is shown as bolder
~~tide~~ is shown as tide
<u>underline</u> is shown as underline

width of this area is 650px fixed.
height of this area is fit-content.
margin top 26px and bottom 74px.
''');
}

class PostView extends StatelessWidget {
  final String id;
  final ModelPost post;

  PostView(String id):
      this.id = id,
      this.post = getPostAPI(id);

  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      floatingBottomBar: BottomSender(BottomSenderType.REPLY),
      appBar: BackAppBar(actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.black,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.bookmark),
          color: Colors.black,
          onPressed: () {},
        )
      ]),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.0, top: 10.0, bottom: 3.0),
          child: UserProfileButton(username: 'kodw0402', position: UsernamePosition.RIGHT_CENTER, size: 38.0),
        ),
        Column(
          children: [
            TitleHeader(this.post.title, isInputHead: true, link: "/post"),
          ],
        ),
        ReplyTile(this.id),
        ReReplyTile(this.id),
        ReplyTile(this.id),
        ReplyTile(this.id),
      ],
    );
  }
}
