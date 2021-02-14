import 'package:padong/core/models/board/reply.dart';

/*
* ModelArgue's parentNodeId is ModelItem
* */

class ModelArgue extends ModelReply {
  int score;

  ModelArgue({
    id,
    title, description,
    this.score,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelArgue.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
