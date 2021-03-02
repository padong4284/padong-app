import 'package:padong/core/node/title_node.dart';

// parent:
class University extends TitleNode {
  String emblemImgURL;

  University.fromMap(String id, Map snapshot)
      : this.emblemImgURL = snapshot['emblemImgURL'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'emblemImgURL': this.emblemImgURL,
    };
  }
}
