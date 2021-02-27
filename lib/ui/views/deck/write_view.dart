import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';

class WriteView extends StatelessWidget {
  final String boardId;
  final Map<String, dynamic> board;

  WriteView(boardId)
      : this.boardId = boardId,
        this.board = getBoardAPI(boardId);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'write',
      titleHint: 'Title of Post',
      withAnonym: true,
      topArea: this.pipLevel(),
      contentHint: this.board['rule'],
      onSubmit: this.createPost,
    );
  }

  Widget pipLevel() {
    String pip = this.board['pip'].toString().split('.')[1];
    pip = pip[0] + pip.toLowerCase().substring(1);
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: 70,
          height: 30,
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            pip,
            style: AppTheme.getFont(
                color: AppTheme.colors.base,
                fontSize: AppTheme.fontSizes.small),
          )),
      Text(
        this.board['title'],
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createPost(Map data) {
    data['pip'] = this.board['pip'];
    data['isAnonym'] = TipInfo.isAnonym;
    createPostAPI(data);
  }
}
