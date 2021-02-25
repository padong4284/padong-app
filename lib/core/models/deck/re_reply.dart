import 'package:meta/meta.dart';
import 'package:padong/core/models/node.dart';

/*
* ModelReReply's parentNodeId is ModelReply
* */
class ModelReReply extends ModelNode {
  String description;
  bool anonymity;
  ModelReReply({
    id, type,
    @required this.description, @required this.anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
      super(
        id: id, type: type ?? "ReReply",
        parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
        createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt
      );

  ModelReReply.fromMap(Map snapshot,String id) :
      this.description = snapshot['description'] ?? "",
      this.anonymity = snapshot['anonymity'] ?? false,
      super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'description': this.description,
      'anonymity': this.anonymity,
    };
  }
}

