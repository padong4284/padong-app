import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padong/core/models/chatroom/chat_message.dart';
import 'package:padong/core/services/firestore_api.dart';

import 'package:padong/locator.dart';


/*
* ModelChatMessage's parentNodeId is ModelChatroom
* */
class ChatMessage extends ModelChatMessage {
  static final FirestoreAPI _chatMessageDB = locator<FirestoreAPI>("Firestore:chatmessage");

  ChatMessage({
    id,
    message,
    attachment,
    parentNodeId, ownerId, pip,
    createdAt, deletedAt, modifiedAt}):
        super(
          id: id,
          parentNodeId: parentNodeId, ownerId: ownerId, pip: pip,
          message: message, attachment: attachment,
          createdAt: createdAt, deletedAt: deletedAt, modifiedAt: modifiedAt);
  ChatMessage.fromMap(Map snapshot,String id) :
        super.fromMap(snapshot, id);

  static Future<ChatMessage> getChatMessageById(String id) async {
    DocumentSnapshot docChatMessage = await _chatMessageDB.ref.doc(id).get();
    if (docChatMessage.exists){
      return ChatMessage.fromMap(docChatMessage.data(), docChatMessage.id);
    }
    throw Exception("ChatMessageId doesn't exists");
  }
}
