import 'package:padong/core/models/deck/post.dart';

/*
* ModelItem's parentNodeId is ModelWiki
* */

class ModelItem extends ModelPost {
  ModelItem({
    id,
    title, description,
    anonymity, attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          anonymity: anonymity,
          attachments: attachments,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelItem.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
