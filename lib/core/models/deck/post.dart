import 'package:padong/core/models/deck/attachment.dart';
import 'package:padong/core/models/title_node.dart';
/*
* ModelPost's parentNodeId is ModelBoard
* */
class ModelPost extends ModelTitleNode{
  bool anonymity;
  List<ModelAttachment> attachments;
  ModelPost({
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

  ModelPost.fromMap(Map snapshot,String id) :
        this.anonymity = snapshot['anonymity'] ?? false,
        this.attachments = snapshot['attachments'].map((x) => ModelAttachment.fromMap(x, id))?? [],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'anonymity': this.anonymity,
      'attachments': this.attachments.map((x) => x.toJson()).toList(),
    };
  }
}

