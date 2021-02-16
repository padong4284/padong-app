import 'package:flutter/cupertino.dart';
import 'package:padong/core/models/chatroom/role.dart';
import 'package:padong/core/models/node.dart';

/*
* ModelParticipant's parentNodeId is ModelChatRoom
* */
class ModelParticipant extends ModelNode {
  ROLE role;
  ModelParticipant({
    id,
    @required this.role,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelParticipant.fromMap(Map snapshot,String id) :
        this.role = ROLE.values[snapshot['role'] ?? ROLE.STUDENT.index],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'role':this.role.index,
    };
  }
}
