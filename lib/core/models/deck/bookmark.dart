import 'package:flutter/cupertino.dart';

import 'like.dart';

/*
* ModelBookmark's parentNodeId is category of ModelPost
* */
class ModelBookmark extends ModelLike {
  ModelBookmark({
    id, @required parentType,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id, type: "Bookmark", parentType: parentType,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelBookmark.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }
}

