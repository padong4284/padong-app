import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/types.dart';

// parent: ChatRoom
class Participant extends Node {
  ROLE role;

  Participant.fromMap(String id, Map snapshot)
      : this.role = parseROLE(snapshot['role']),
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'role': roleToString(this.role),
    };
  }

  int countUnread() {
    // TODO: based on Participant's modifiedAt, message's createdAt
    return 0;
  }
}
