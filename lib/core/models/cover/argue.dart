import 'package:meta/meta.dart';
import 'package:padong/core/models/deck/reply.dart';

/*
* ModelArgue's parentNodeId is ModelItem
* */

class ModelArgue extends ModelReply {
  bool isClosed;
  ModelArgue({
    id,
    title, description,
    @required this.isClosed,
    anonymity,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(id: id, type: "Argue",
          description: description,
          anonymity: anonymity,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelArgue.fromMap(Map snapshot,String id) :
      this.isClosed = snapshot['isClosed'] ?? false,
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      "isClosed":this.isClosed
    };
  }

}
