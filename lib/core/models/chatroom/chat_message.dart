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
    this.message,
    this.attachment,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelChatMessage.fromMap(Map snapshot,String id) :
        this.message = snapshot['message'] ?? "",
        this.attachment = snapshot['attachment'] ?? null,
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'attachment': this.attachment,
    };
  }
}

