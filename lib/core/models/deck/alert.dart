import 'package:meta/meta.dart';

import 'like.dart';

/*
* ModelAlert's parentNodeId is category of ModelBoard, ModelPost
* */
class ModelAlert extends ModelLike {
  ModelAlert({
    id, @required parentType,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id, type: "Alert", parentType: parentType,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelAlert.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }
}

