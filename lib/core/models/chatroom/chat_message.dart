import 'package:padong/core/models/board/attachment.dart';

import '../node.dart';

/*
* ModelChatMessage's parent is ModelChatRoom
* */
class ModelChatMessage extends ModelNode {
  String message;
  List<ModelAttachment> attachments;
  ModelChatMessage({
    id,
    this.message,
    this.attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelChatMessage.fromMap(Map snapshot,String id) :
        this.message = snapshot['message'] ?? "",
        this.attachments = snapshot['attachments'] ?? [],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'message': this.message,
      'attachments': this.attachments.map((x) => x.toJson()).toList(),
    };
  }
}

