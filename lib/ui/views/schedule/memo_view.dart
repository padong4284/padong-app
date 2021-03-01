import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/core/apis/schedule.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';

class MemoView extends StatelessWidget {
  final String eventId;
  final Map<String, dynamic> event;

  MemoView(eventId)
      : this.eventId = eventId,
        this.event = getEventAPI(eventId);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'memo',
      titleHint: 'Title of Memo',
      contentHint: MemoHint,
      withAnonym: true,
      topArea: this.lectureInfo(),
      onSubmit: this.createMemo,
    );
  }

  Widget lectureInfo() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          height: 30,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            this.event['title'],
            style: AppTheme.getFont(color: AppTheme.colors.base),
          )),
      Text(
        this.event['periodicity'],
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createMemo(Map data) {
    data['parentId'] = this.eventId;
    data['isAnonym'] = TipInfo.isAnonym;
    createPostAPI(data);
  }
}

const String MemoHint = """You can memo anything!
Memo is always Internal.

only you and your friends can read and write!
""";