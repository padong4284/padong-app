import 'package:padong/core/node/node.dart';

class TitleNode extends Node {
  String title;
  String description;

  TitleNode.fromMap(Map snapshot, String id)
      : this.title = snapshot['title'],
        this.description = snapshot['description'],
        super.fromMap(snapshot, id);

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': this.title,
      'description': this.description,
    };
  }
}
