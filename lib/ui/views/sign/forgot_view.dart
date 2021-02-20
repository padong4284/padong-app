import 'package:flutter/material.dart';
import 'package:padong/ui/widgets/inputs/markdown_supporter.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';
import 'package:padong/ui/widgets/tiles/chat_balloon.dart';

class ForgotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(title: 'tae7130'),
        children: [
          ChatBalloon('0123'),
        ],
        floatingBottomBar: (_) => MarkdownSupporter()
    );
  }
}
