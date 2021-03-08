import 'package:flutter/material.dart';
import 'package:padong/core/apis/deck.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';
import 'package:padong/ui/widgets/bars/floating_bottom_bar.dart';

class ServeView extends StatelessWidget {
  final String buildingId;
  final Map<String, dynamic> building;

  ServeView(buildingId)
      : this.buildingId = buildingId,
        this.building = getBoardAPI(buildingId);

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'write',
      titleHint: 'Title of Post',
      withAnonym: true,
      topArea: this.pipLevel(),
      contentHint: this.building['rule'],
      onSubmit: this.createPost,
    );
  }

  Widget pipLevel() {
    String pip = this.building['pip'].toString().split('.')[1];
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
        this.building['title'],
        style: AppTheme.getFont(isBold: true),
      )
    ]);
  }

  void createPost(Map data) {
    data['parentId'] = this.building;
    data['pip'] = this.building['pip'];
    data['isAnonym'] = TipInfo.isAnonym;
    createPostAPI(data);
  }
}