
import 'package:flutter/foundation.dart';
import 'package:padong/core/models/deck/attachment.dart';
import 'package:padong/core/models/node.dart';

/*
* ModelChatMessage's parentNodeId is ModelChatRoom
* */
class ModelChatMessage extends ModelNode {
  String message;
  ModelAttachment attachment;

  ModelChatMessage({
    id,
    @required this.message,
    this.attachment,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelChatMessage.fromMap(Map snapshot,String id) :
        message = snapshot['message'] ?? "",
        attachment = snapshot['attachment'] ?? null,
        assert(message.length > 0 || attachment != null),
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'attachment': this.attachment,
    };
  }
}

