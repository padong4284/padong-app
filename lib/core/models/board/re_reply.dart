import '../node.dart';
/*
* ModelReply's parent is Reply
* */
class ModelReReply extends ModelNode {
  String description;
  bool anonymity;
  ModelReReply({
    id,
    this.description, this.anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

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

