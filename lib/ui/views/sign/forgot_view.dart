import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/inputs/bottom_sender.dart';
import 'package:padong/ui/views/templates/safe_padding_template.dart';
import 'package:padong/ui/widgets/bars/back_app_bar.dart';

class ForgotView extends StatelessWidget {
  final TextEditingController msgCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
        appBar: BackAppBar(title: 'tae7130'),
        floatingBottomBar: BottomSender(BottomSenderType.REVIEW, msgController: msgCotroller),
        children: [
        ],
    );
  }
}
