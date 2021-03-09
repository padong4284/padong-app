import 'package:padong/core/node/cover/argue.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/service/padong_fb.dart';
import 'package:padong/core/shared/statistics.dart';

// parent: Cover
class Wiki extends TitleNode with Statistics {
  List<String> backLinks; // List of wikiId
  List<String> frontLinks; // List of wikiId
  List<Argue> _argues;

  List<Argue> get argues {
    // TODO: check does it work?
    if (this._argues == null) this._getArgues();
    return this._argues;
  }

  Wiki();

  Wiki.fromMap(String id, Map snapshot)
      : this.backLinks = snapshot['backLinks'],
        this.frontLinks = snapshot['frontLinks'],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => Wiki.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'backLinks': this.backLinks,
      'frontLinks': this.frontLinks,
    };
  }

  void _getArgues() async {
    this._argues = await PadongFB.getDocsByRule(Argue().type,
            rule: (query) => query.where('wikiId', isEqualTo: this.id))
        .then((docs) =>
            docs.map((doc) => Argue.fromMap(doc.id, doc.data())).toList());
  }

  void updateBackLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase with Transaction, Target Wiki's frontLinks update
  }

  void updateFrontLinks(String targetWikiId, {bool isRemove = false}) async {
    // TODO: update firebase with Transaction, Target Wiki's backLinks update
  }
}
