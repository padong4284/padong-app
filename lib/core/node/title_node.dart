import 'package:padong/core/node/node.dart';

class TitleNode extends Node {
  String title;
  String description;

  TitleNode.fromMap(String id, Map snapshot)
      : this.title = snapshot['title'],
        this.description = snapshot['description'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': this.title,
      'description': this.description,
    };
  }
}
