import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/types.dart';

// parent: University
class User extends Node {
  String uid;
  String name;
  String userId;
  bool isVerified;
  int entranceYear;
  List<String> userEmails;
  String profileImageURL;
  List<String> friendIds; // I request be friend

  User.fromMap(String id, Map snapshot)
      : this.uid = snapshot['uid'],
        this.name = snapshot['name'],
        this.userId = snapshot['userId'],
        this.isVerified = snapshot['isVerified'],
        this.entranceYear = snapshot['entranceYear'],
        this.userEmails = snapshot['userEmails'],
        this.profileImageURL = snapshot['profileImageURL'],
        this.friendIds = snapshot['friendIds'],
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'uid': this.uid,
      'name': this.name,
      'userId': this.userId,
      'isVerified': this.isVerified,
      'entranceYear': this.entranceYear,
      'userEmails': this.userEmails,
      'profileImageURL': this.profileImageURL,
      'friendIds': this.friendIds,
    };
  }

  RELATION getRelationWith(User other) {
    bool received = this.friendIds.contains(other.id);
    bool send = other.friendIds.contains(this.id);
    if (received) {
      if (send) return RELATION.FRIEND;
      return RELATION.RECEIVED;
    }
    if (send) return RELATION.SEND;
    return null;
  }
}
