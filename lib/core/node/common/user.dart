import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/chat/chat_room.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: University
class User extends Node {
  String name;
  String userId;
  bool isVerified;
  int entranceYear;
  List<String> userEmails;
  String profileImageURL;
  List<String> friendIds; // I send

  User();

  User.fromMap(String id, Map snapshot)
      : this.name = snapshot['name'],
        this.userId = snapshot['userId'],
        this.isVerified = snapshot['isVerified'],
        this.entranceYear = snapshot['entranceYear'],
        this.userEmails = <String>[...snapshot['userEmails']],
        this.profileImageURL = snapshot['profileImageURL'],
        this.friendIds = <String>[...snapshot['friendIds']],
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => User.fromMap(id, snapshot);

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

  static Future<User> getByUserId(String userId) async {
    List<DocumentSnapshot> users = (await PadongFB.getDocsByRule(User().type,
        rule: (query) => query.where("userId", isEqualTo: userId), limit: 1));
    if (users.isEmpty) return null;
    return User.fromMap(users.first.id, users.first.data());
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

  Future<List<ChatRoom>> getMyChatRooms(User me) async {
    if (this != me) throw Exception("Not me!");

    List<String> chatRoomIds;
    List<DocumentSnapshot> myParticipants = await PadongFB.getDocsByRule(
        Participant().type,
        rule: (query) => query.where('ownerId', isEqualTo: me.id));
    for (DocumentSnapshot p in myParticipants) chatRoomIds.add(p['parentId']);

    return await PadongFB.getDocsByRule(ChatRoom().type,
            rule: (query) => query.where('id', whereIn: chatRoomIds))
        .then((docs) =>
            docs.map((doc) => ChatRoom.fromMap(doc.id, doc.data())).toList());
  }
}
