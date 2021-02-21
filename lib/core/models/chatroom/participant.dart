import 'package:meta/meta.dart';
import 'package:padong/core/models/chatroom/role.dart';

/*
* ModelParticipant's parentNodeId is ModelChatRoom
* */
class Participant {
  ROLE role;
  String userId;

  Participant({
    @required this.role,
    @required this.userId,
  });

  Participant.fromMap(Map snapshot,String id) :
        this.role = ROLE.values[snapshot['role'] ?? ROLE.STUDENT.index],
        this.userId = snapshot['userId'];

  toJson() {
    return {
      'role':this.role.index,
      'userId': this.userId,
    };
  }
}