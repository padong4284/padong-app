import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padong/core/models/deck/post.dart';
import 'package:padong/core/models/user/user.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/tiles/node/re_reply_tile.dart';
import 'package:padong/ui/widgets/tiles/node/reply_tile.dart';
import 'package:padong/ui/widgets/title_header.dart';

ModelUser getUserById(String id) {
  return ModelUser(id:id, userName: 'kodw0402');
}

ModelPost getPostAPI(String id) {
  return ModelPost(title: 'Title', createdAt: DateTime(2021, 5, 13, 13, 13), description: '''
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
  final ModelUser user;

  PostView(String id)
      : this.id = id,
        this.post = getPostAPI(id),
        this.user = getUserById(id);

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
        _buildAuthorBar(),
        _buildMarkdown(),
        ReplyTile(this.id),
        ReReplyTile(this.id),
        ReplyTile(this.id),
        ReplyTile(this.id),
      ],
    );
  }

  List<String> getTimes() {
    final List<String> splitedTime = this.post.createdAt.toIso8601String().split('T');
    final String yearMonthDay = splitedTime[0];

    final List<String> splitedHourMin = splitedTime[1].split(':');
    final String time = '${splitedHourMin[0]}:${splitedHourMin[1]}';
    return [yearMonthDay, time];
  }

  Widget _buildAuthorBar() {
    return Padding(
      padding: EdgeInsets.only(left: 1.0, top: 10.0, bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserProfileButton(
              username: this.user.userName,
              position: UsernamePosition.RIGHT_CENTER,
              size: 38.0),
          Row(
            children: [
              Text(getTimes()[0], style: AppTheme.getFont(
                    color: AppTheme.colors.semiSupport
                )),
              Padding(
                padding: EdgeInsets.only(left: 4.0, right: 12.0),
                child: Text(getTimes()[1], style: AppTheme.getFont(
                    color: AppTheme.colors.semiSupport
                ))
              )
          ])
        ],
      ),
    );
  }

  Widget _buildMarkdown() {
    return Column(
      children: [
        TitleHeader(this.post.title, isInputHead: true, link: "/post"),
        PadongMarkdown(this.post.description),
        Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Stack(
              children: [
                BottomButtons(left: -12, bottoms: [1, 2, 3]),
                Positioned(
                    bottom: 3,
                    right: 0,
                    child: TranspButton(
                        buttonSize: ButtonSize.SMALL,
                        icon: Icon(Icons.more_horiz,
                            color: AppTheme.colors.support, size: 20),
                        callback: () {}))
              ],
            )
        ),
        _underLine()
      ],
    );
  }

  Widget _underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }
}
