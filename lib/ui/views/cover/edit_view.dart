import 'package:flutter/material.dart';
import 'package:padong/core/apis/cover.dart';
import 'package:padong/ui/views/templates/markdown_editor_template.dart';

class EditView extends StatelessWidget {
  final String coverId;
  final String wikiId;
  final Map<String, dynamic> cover;
  final Map<String, dynamic> wiki;

  EditView(coverId, {wikiId})
      : this.coverId = coverId,
        this.cover = getCoverAPI(coverId),
        this.wikiId = wikiId,
        this.wiki = wikiId != null ? getWikiAPI(wikiId) : null;

  @override
  Widget build(BuildContext context) {
    return MarkdownEditorTemplate(
      editTxt: 'edit',
      titleHint: 'Title of Wiki',
      initPIP: this.wiki != null ? wiki['pip'] : null,
      title: this.wiki != null ? wiki['title'] : null,
      content: this.wiki != null ? wiki['description'] : null,
      onSubmit: this.wikiId != null ? this.updateWiki : this.createWiki,
    );
  }

  void createWiki(Map data) {
    data['parentId'] = this.coverId;
    createWikiAPI(data);
  }

  void updateWiki(Map data) {
    data['parentId'] = this.wikiId;
    createItemAPI(data);
  }
}
