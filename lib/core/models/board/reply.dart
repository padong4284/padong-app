import '../node.dart';

/*
* ModelReply's parent is ModelPost
* */
class ModelReply extends ModelNode {
  String description;
  bool anonymity;
  ModelReply({
    id,
    this.description, this.anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelReply.fromMap(Map snapshot,String id) :
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

