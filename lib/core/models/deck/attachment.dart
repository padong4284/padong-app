import 'package:meta/meta.dart';
import 'package:padong/core/models/node.dart';

/*
* ModelAttachment has no parent
* */
class ModelAttachment extends ModelNode {
  String type;
  String location;

  ModelAttachment({
    id,
    @required this.type, @required this.location,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelAttachment.fromMap(Map snapshot,String id) :
        this.type = snapshot['anonymity'] ?? "",
        this.location = snapshot['location'] ?? "",
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'type': this.type,
      'location': this.location,
    };
  }
}

