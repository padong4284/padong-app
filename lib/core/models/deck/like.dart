import 'package:padong/core/models/node.dart';
import 'package:meta/meta.dart';

/*
* ModelLike's parentNodeId is ModelPost
* */
class ModelLike extends ModelNode {
  String parentType;

  ModelLike({
    id, type, @required this.parentType,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id, type: type ?? "Like",
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelLike.fromMap(Map snapshot,String id) :
      this.parentType = snapshot['parentType'] ?? "",
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
    "parentType": this.parentType
    };
  }
}

