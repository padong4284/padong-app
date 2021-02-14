import 'package:padong/core/models/board/post.dart';

/*
* ModelEvent's parentNodeId is ModelTable
* */

class ModelEvent extends ModelPost {
  ModelEvent({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelEvent.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
