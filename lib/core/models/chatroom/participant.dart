import 'package:padong/core/models/chatroom/role.dart';
import 'package:padong/core/models/node.dart';

/*
* ModelParticipant's parentNodeId is ModelChatRoom
* */
class Participant extends ModelNode {
  ROLE role;

  Participant.fromMap(Map snapshot,String id) :
        this.role = ROLE.values[snapshot['role'] ?? ROLE.STUDENT.index],
        super.fromMap(snapshot, id);

  toJson() {
    return {
      ...super.toJson(),
      'role':this.role.index,
    };
  }
}