import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/buttons/bottom_buttons.dart';
import 'package:padong/ui/widgets/buttons/transp_button.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/widgets/paddong_markdown.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/title_header.dart';

class PostView extends StatelessWidget {
  final String id;
  final Map<String, dynamic> post;

  PostView(String id)
      : this.id = id,
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
        this.authorBar(),
        this.content(),
      ],
    );
  }

  List<String> getTimes() {
    final List<String> splitedTime =
        this.post['createdAt'].toIso8601String().split('T');
    final String yearMonthDay = splitedTime[0];

    final List<String> splitedHourMin = splitedTime[1].split(':');
    final String time = '${splitedHourMin[0]}:${splitedHourMin[1]}';
    return [yearMonthDay, time];
  }

  Widget authorBar() {
    return Padding(
      padding: EdgeInsets.only(left: 1.0, top: 10.0, bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserProfileButton(this.post['ownerId'],
              position: UsernamePosition.RIGHT_CENTER, size: 38.0),
          Row(children: [
            Text(getTimes()[0],
                style: AppTheme.getFont(color: AppTheme.colors.semiSupport)),
            Padding(
                padding: EdgeInsets.only(left: 4.0, right: 12.0),
                child: Text(getTimes()[1],
                    style:
                        AppTheme.getFont(color: AppTheme.colors.semiSupport)))
          ])
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        TitleHeader(this.post['title'], isInputHead: true, link: "/post"),
        PadongMarkdown(this.post['description']),
        Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Stack(
              children: [
                BottomButtons(bottoms: this.post['bottoms']),
                Positioned(
                    bottom: 3,
                    right: 0,
                    child: TranspButton(
                        buttonSize: ButtonSize.SMALL,
                        icon: Icon(Icons.more_horiz,
                            color: AppTheme.colors.support, size: 20),
                        callback: () {}))
              ],
            )),
        this.underLine()
      ],
    );
  }

  Widget underLine() {
    return Container(
        height: 2,
        color: AppTheme.colors.lightSupport,
        margin: const EdgeInsets.only(top: 5));
  }
}
