import 'package:padong/core/models/deck/post.dart';

/*
* ModelService's parentNodeId is ModelBuilding
* */

class ModelService extends ModelPost {
  ModelService({
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

  ModelService.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
