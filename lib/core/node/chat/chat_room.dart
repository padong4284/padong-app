import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/node.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/notification.dart';

// parent: Lecture or null
class ChatRoom extends TitleNode with Notification {
  Message lastMessage;

  ChatRoom.fromMap(String id, Map snapshot)
      : this.lastMessage = Message.fromMap(
            snapshot['lastMessage']['id'], snapshot['lastMessage']),
        super.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'lastMessage': this.lastMessage.toJson(),
    };
  }

  Future<bool> addParticipant(User user, [String role]) async {
    return Participant().create(this.id, {
      'role': role ?? "STUDENT",
      'ownerId': user.id,
      'pip': "INTERNAL",
    });
  }

  Future<Stream<QuerySnapshot>> getChatStream() async {
    return fireDB
        .collection(this.type)
        .where("parentId", isEqualTo: this.id)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<List<Message>> getChatmessages(String chatroomId,
      [Message startAt, int limit = 500]) async {
    Query query = _chatmessageDB.ref
        .where("parentNodeId", isEqualTo: chatroomId)
        .orderBy("createdAt", descending: true);
    if (startAt != null) {
      var doc = await _chatmessageDB.getDocumentById(startAt.id);
      if (doc.exists) {
        query = query.startAtDocument(doc);
      }
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    QuerySnapshot queryMessages = await query.get();
    List<Message> result;
    for (var i in queryMessages.docs) {
      result.add(Message.fromMap(i.data(), i.id));
    }
    return result;
  }
}
