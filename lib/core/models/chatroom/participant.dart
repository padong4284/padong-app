import 'package:padong/core/models/chatroom/role.dart';

import '../node.dart';

class ModelParticipant extends ModelNode {
  ROLE role;
  ModelParticipant({
    id,
    this.role,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);

  ModelParticipant.fromMap(Map snapshot,String id) :
        this.role = snapshot['role'] ?? ROLE.STUDENT,
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'role':this.role,
    };
  }
}
