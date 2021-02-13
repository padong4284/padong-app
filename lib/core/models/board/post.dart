import '../board/attachment.dart';

import '../title_node.dart';

class ModelReply extends ModelTitleNode{
  bool anonymity;
  List<ModelAttachment> attachments;
  ModelReply({
    id,
    title, description,
    this.anonymity,
    this.attachments,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          title: title, description: description,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelReply.fromMap(Map snapshot,String id) :
        this.anonymity = snapshot['anonymity'] ?? false,
        this.attachments = snapshot['attachments'] ?? [],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'attachments': this.attachments,
    };
  }
}

