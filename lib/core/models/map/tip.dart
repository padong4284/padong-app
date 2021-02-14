import 'package:padong/core/models/board/reply.dart';

/*
* ModelTip's parentNodeId is ModelService
* */

class ModelTip extends ModelReply {
  int score;

  ModelTip({
    id,
    title, description,
    this.score,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelTip.fromMap(Map snapshot,String id) :
        this.score = snapshot['score'] ?? 0,
        super.fromMap(snapshot, id);

  toJson() {
    if (this.score < 0) {
      this.score = 0;
    } else if( this.score > 5){
      this.score = 5;
    }
    return {
      ...super.toJson(),
      'score':this.score,
    };
  }

}
