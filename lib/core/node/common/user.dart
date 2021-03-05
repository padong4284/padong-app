import 'package:padong/core/node/node.dart';
import 'package:padong/core/services/padong_fb.dart';
import 'package:padong/core/shared/types.dart';

// parent: University
class User extends Node {
  String name;
  String userId;
  bool isVerified;
  int entranceYear;
  List<String> userEmails;
  String profileImageURL;
  List<String> friendIds; // I request be friend

  User.fromMap(String id, Map snapshot)
      : this.name = snapshot['name'],
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

  static Future<User> getByUserId(String userId) async {
    return (await PadongFB.getNodesByRule(User,
        rule: (query) => query.where("userId", isEqualTo: userId),
        limit: 1))[0];
  }
}
