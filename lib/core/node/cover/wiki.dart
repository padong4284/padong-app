import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/services/padong_fb.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Cover
class Wiki extends TitleNode with Statistics {
  List<String> backLinks; // List of wikiId
  List<String> frontLinks; // List of wikiId

  Wiki.fromMap(String id, Map snapshot)
      : this.backLinks = snapshot['backLinks'],
        this.frontLinks = snapshot['frontLinks'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'backLinks': this.backLinks,
      'frontLinks': this.frontLinks,
    };
  }

  List<Argue> getArgues() {
    // TODO: without getChildren
    // using wikiId
    return [];
  }

  void updateBackLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase
    Wiki target = await PadongFB.getNode(Wiki, targetWikiId);
    bool isContain = this.backLinks.contains(targetWikiId);
    if (isRemove && isContain) {
      this.backLinks.remove(targetWikiId);
      target.updateFrontLinks(this.id, isRemove: true);
    } else if (!isContain) {
      this.backLinks.add(targetWikiId);
      target.updateFrontLinks(this.id);
    }
  }

  void updateFrontLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase
    Wiki target = await PadongFB.getNode(Wiki, targetWikiId);
    bool isContain = this.backLinks.contains(targetWikiId);
    if (isRemove && isContain) {
      this.frontLinks.remove(targetWikiId);
      target.updateBackLinks(this.id, isRemove: true);
    } else if (!isContain) {
      this.frontLinks.add(targetWikiId);
      target.updateBackLinks(this.id);
    }
  }
}
