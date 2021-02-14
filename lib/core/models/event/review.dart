import 'package:padong/core/models/deck/post.dart';

/*
* ModelEvent's parentNodeId is ModelTable
* */

class ModelReview extends ModelPost {
  ModelReview({
    id,
    title, description,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelReview.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return this.toJson();
  }

}
