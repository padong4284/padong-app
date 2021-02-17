import 'package:meta/meta.dart';

import "../models/node.dart";

class ModelTitleNode extends ModelNode {
  String title;
  String description;

  ModelTitleNode(
      {id,
      @required this.title,
      @required this.description,
      parentNodeId,
      ownerId,
      pip,
      createdAt,
      deletedAt,
      modifiedAt})
      : super(
            id: id,
            parentNodeId: parentNodeId,
            ownerId: ownerId,
            pip: pip,
            createdAt: createdAt,
            deletedAt: deletedAt,
            modifiedAt: modifiedAt);

  ModelTitleNode.fromMap(Map snapshot, String id)
      : this.title = snapshot['title'] ?? "",
        this.description = snapshot['description'] ?? "",
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'title': this.title,
      'description': this.description,
    };
  }
}
