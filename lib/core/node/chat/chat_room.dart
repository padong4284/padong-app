import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/node/chat/message.dart';
import 'package:padong/core/node/chat/participant.dart';
import 'package:padong/core/node/common/user.dart';
import 'package:padong/core/node/title_node.dart';
import 'package:padong/core/shared/notification.dart';
import 'package:padong/core/service/padong_fb.dart';

// parent: Lecture or null
class ChatRoom extends TitleNode with Notification {
  Message lastMessage;

  ChatRoom();

  ChatRoom.fromMap(String id, Map snapshot)
      : this.lastMessage = Message.fromMap(
            snapshot['lastMessage']['id'], snapshot['lastMessage']),
        super.fromMap(id, snapshot);

  @override
  generateFromMap(String id, Map snapshot) => ChatRoom.fromMap(id, snapshot);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'lastMessage': this.lastMessage.toJson(),
    };
  }

  Future<Participant> addParticipant(User user, [String role]) async {
    return await Participant.fromMap('', {
      'pip': this.pip,
      'parentId': this.id,
      'ownerId': user.id,
      'role': role ?? "STUDENT",
    }).create();
  }

  Future<bool> chatMessage(String msg, {bool isImage = false}) async {
    Message message = await Message.fromMap('', {
      'pip': this.pip,
      'parentId': this.id,
      'message': msg,
      'isImage': isImage,
    }).create();
    if (message == null) return false;
    this.lastMessage = message;
    return await this.update();
  }

  Future<Stream<QuerySnapshot>> getMessageStream() async {
    return await PadongFB.getQueryStreamByRule(
      Message().type,
      rule: (query) => query
          .where("parentId", isEqualTo: this.id)
          .orderBy("createdAt", descending: true),
      limit: 30,
    );
  }
}
