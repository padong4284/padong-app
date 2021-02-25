import 'package:padong/core/models/event/opinion.dart';

/*
* ModelTip's parentNodeId is ModelService
* */

class ModelTip extends ModelOpinion {
  ModelTip({
    id,
    title, description,
    score,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id, type: "Tip",
          description: description,
          score: score,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelTip.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
