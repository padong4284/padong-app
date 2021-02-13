import '../node.dart';

class ModelVote extends ModelNode {
  bool isThumbsUp;
  ModelVote({
    id,
    this.isThumbsUp,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelVote.fromMap(Map snapshot,String id) :
        this.isThumbsUp = snapshot['isThumbsUp'] ?? true,
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'isThumbsUp': this.isThumbsUp,
    };
  }
}

