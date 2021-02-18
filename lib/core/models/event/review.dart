import 'package:padong/core/models/deck/post.dart';

/*
* ModelReview's parentNodeId is ModelLecture
* */

class ModelReview extends ModelPost {
  ModelReview({
    id,
    title, description,
    anonymity, attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          anonymity: anonymity, attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelReview.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return this.toJson();
  }

}
