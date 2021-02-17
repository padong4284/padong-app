import 'package:padong/core/models/deck/post.dart';

/*
* ModelMemo's parentNodeId is ModelTable
* */

class ModelEvent extends ModelPost {
  ModelEvent({
    id,
    title, description,
    attachments, anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id,
          title:title, description: description,
          attachments: attachments, anonymity: anonymity,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelEvent.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  toJson() {
    return super.toJson();
  }

}
